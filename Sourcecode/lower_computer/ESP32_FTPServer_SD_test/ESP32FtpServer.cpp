/**
 * FTP Serveur for ESP8266
 * based on FTP Serveur for Arduino Due and Ethernet shield (W5100) or WIZ820io (W5200)
 * based on Jean-Michel Gallego's work
 * modified to work with esp8266 SPIFFS by David Paiva david@nailbuster.com
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
// 2017: modified by @robo8080
// 2019: modified by @fa1ke5

#include "ESP32FtpServer.h"

#include <WiFi.h>
//#include <ESP32WebServer.h>
#include <FS.h>
#include <SD_MMC.h>
//#include "SPI.h"

WiFiServer ftpServer(FTP_CTRL_PORT);
WiFiServer dataServer(FTP_DATA_PORT_PASV);

// fs::FS &convertor(fs::FS &fs) {return fs;}

void FtpServer::begin(String uname, String pword)  // 服务器初始化
{
   // Tells the ftp server to begin listening for incoming connection
   _FTP_USER = uname;  // 设置用户名
   _FTP_PASS = pword;  // 设置密码

   ftpServer.begin();
   delay(10);
   dataServer.begin();
   delay(10);
   millisTimeOut = (uint32_t)FTP_TIME_OUT * 60 * 1000;  // 长时间无响应断开时间(单位: 分钟)
   millisDelay   = 0;

   cmdStatus = 0;  // 服务器状态初始化
   iniVariables();
}

void FtpServer::iniVariables()  // 变量初始化
{
#ifdef FTP_DEBUG
   Serial.println("call iniVariables");
#endif


   // Default for data port
   dataPort = FTP_DATA_PORT_PASV;

   // Default Data connection is Active
   dataPassiveConn = true;

   // Set the root directory
   strcpy(cwdName, "/");

   rnfrCmd        = false;
   transferStatus = 0;  // 数据传输状态初始化
}

void FtpServer::handleFTP()  // 处理函数
{
#ifdef FTP_DEBUG
   Serial.println("call handleFTP");
#endif


   if ((int32_t)(millisDelay - millis()) > 0) {  // 与上一个客户中断连接后delay一段时间才重新开始初始化并提供服务
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-1");
#endif

      return;
   }

   if (ftpServer.hasClient()) {  // 有新的客户连接
                                 //    if (ftpServer.available()) {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-2");
#endif

      client.stop();  // 关闭旧链接, 启动新连接
      client = ftpServer.available();
   }

   if (cmdStatus == 0) {
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-3");
#endif

      if (client.connected()) {  // 服务初始化, 停止已经建立的连接
#ifdef FTP_DEBUG
         Serial.println("call handleFTP-3-1");
#endif

         disconnectClient();  // 中断连接, 终止数据传输活动
      }
      cmdStatus = 1;
   }
   else if (cmdStatus == 1)  // Ftp server waiting for connection 初始化变量
   {
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-4");
#endif

      abortTransfer();  // 终止数据传输活动
      iniVariables();   // 初始化变量

#ifdef FTP_DEBUG
      Serial.println("Ftp server waiting for connection on port " + String(FTP_CTRL_PORT));
#endif


      cmdStatus = 2;
   }
   else if (cmdStatus == 2)  // Ftp server idle 服务器空闲, 等待连接
   {
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-5");
#endif

      if (client.connected())  // A client connected // 收到客户端连接请求
      {
#ifdef FTP_DEBUG
         Serial.println("call handleFTP-5-1");
#endif

         clientConnected();                           // 初始化命令行的指针, 指向第一个空
         millisEndConnection = millis() + 10 * 1000;  // wait client id during 10 s.
         cmdStatus           = 3;                     // 服务器验证用户名状态
      }
   }
   else if (readChar() > 0)  // got response 已获得一条格式合法的请求命令
   {
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-6");
#endif

      if (cmdStatus == 3) {  // Ftp server waiting for user identity 服务器应该验证用户了

#ifdef FTP_DEBUG
         Serial.println("call handleFTP-6-1");
#endif

         if (userIdentity()) {  // 用户名验证成功
#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-1-1");
#endif

            cmdStatus = 4;  // 服务器验证密码状态
         }
         else {  // 用户名验证失败
#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-1-2");
#endif

            cmdStatus = 0;  // 重置服务器状态
         }
      }
      else if (cmdStatus == 4)  // Ftp server waiting for user registration 服务器应该验证密码了
      {
#ifdef FTP_DEBUG
         Serial.println("call handleFTP-6-2");
#endif

         if (userPassword()) {  // 服务器密码验证成功
#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-2-1");
#endif

            cmdStatus           = 5;  // 服务器工作状态
            millisEndConnection = millis() + millisTimeOut;
         }
         else {  // 密码验证失败
#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-2-2");
#endif

            cmdStatus = 0;  // 重置服务器状态
         }
      }
      else if (cmdStatus == 5)  // Ftp server waiting for user command 服务器工作状态
      {
#ifdef FTP_DEBUG
         Serial.println("call handleFTP-6-3");
#endif

         if (!processCommand()) {  // 验证客户请求指令, 返回false为客户发送的退出请求(QUIT)
#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-3-1");
#endif

            cmdStatus = 0;  // 初始化服务器状态
         }
         else {  // 其他非退出的请求指令
#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-3-2");
#endif

            millisEndConnection = millis() + millisTimeOut;  // 更新终止响应的时间
         }
      }
   }
   // else if (!client.connected() || !client) {  // 当前无客户端请求连接
   else if (!client.connected()) {  // 当前无客户端请求连接
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-7");
#endif

      cmdStatus = 1;  // 状态: 初始化变量后等待下一次连接申请

#ifdef FTP_DEBUG
      Serial.println("client disconnected");
#endif
   }

   if (transferStatus == 1)  // Retrieve data 数据传输为下载状态
   {
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-8");
#endif

      if (!doRetrieve()) {  // 传输完成后结束后结束下载状态, 转变为默认状态
#ifdef FTP_DEBUG
         Serial.println("call handleFTP-8");
#endif
         transferStatus = 0;
      }
   }
   else if (transferStatus == 2)  // Store data 数据传输为上传状态
   {
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-9");
#endif

      if (!doStore()) {  // 传输完成后结束后结束上传状态, 转变为默认状态
#ifdef FTP_DEBUG
         Serial.println("call handleFTP-9-1");
#endif

         transferStatus = 0;
      }
   }
   else if (cmdStatus > 2 && !((int32_t)(millisEndConnection - millis()) > 0)) {  // 一段时间为收到已连接客户端的请求命令
#ifdef FTP_DEBUG
      Serial.println("call handleFTP-10");
#endif

      client.println("530 Timeout");
      millisDelay = millis() + FTP_TIME_OUT;  // delay of FTP_TIME_OUT ms 服务器暂停 FTP_TIME_DELAY ms

      cmdStatus = 0;  // 终止与该客户的连接, 并初始化服务器
   }
}

void FtpServer::clientConnected()  // 连接成功, 刚刚建立连接时调用
{
#ifdef FTP_DEBUG
   Serial.println("Client connected!");
#endif

   client.println("220--- Welcome to FTP for ESP32---");
   client.println("220---     By Zuoqiu-Yingyi     ---");
   client.println("220 --     Version " + String(FTP_SERVER_VERSION) + "     --");
   iCL = 0;  // 刚刚建立连接, 此时请求的命令应为空, 命令字符串的指针也复位, 指向第一个空
}

void FtpServer::disconnectClient()  // 中断连接
{
#ifdef FTP_DEBUG
   Serial.println(" Disconnecting client");
#endif

   abortTransfer();  // 终止数据传输活动
   client.println("221 Goodbye");
   client.stop();  // 终止TCP连接
}

boolean FtpServer::userIdentity()  // 验证用户名
{
#ifdef FTP_DEBUG
   Serial.println("call userIdentity");
#endif


   if (strcmp(command, "USER")) {  // 若客户端指令不匹配"USER"
#ifdef FTP_DEBUG
      Serial.println("call userIdentity-1");
#endif

      client.println("500 Syntax error");
   }
   if (strcmp(parameters, _FTP_USER.c_str())) {  // 若客户端发送的用户名与服务器设定的用户名不匹配
#ifdef FTP_DEBUG
      Serial.println("call userIdentity-2");
#endif


      client.println("530 user not found");
   }
   else {  // 若用户名验证成功
#ifdef FTP_DEBUG
      Serial.println("call userIdentity-3");
#endif


      client.println("331 OK. Password required");
      strcpy(cwdName, "/");  // 文件路径初始化为根目录
      return true;
   }
   millisDelay = millis() + FTP_TIME_DELAY;  // delay of FTP_TIME_DELAY ms 服务器暂停 FTP_TIME_DELAY ms
   return false;
}

boolean FtpServer::userPassword()  // 验证密码
{
#ifdef FTP_DEBUG
   Serial.println("call userPassword");
#endif


   if (strcmp(command, "PASS")) {  // 若客户端请求指令不匹配"PASS"
#ifdef FTP_DEBUG
      Serial.println("call userPassword-1");
#endif


      client.println("500 Syntax error");
   }
   else if (strcmp(parameters, _FTP_PASS.c_str())) {  // 若客户端密码参数不匹配服务器设置的密码
#ifdef FTP_DEBUG
      Serial.println("call userPassword-2");
#endif


      client.println("530 ");
   }
   else {  // 若客户端密码参数匹配服务器设置的密码
#ifdef FTP_DEBUG
      Serial.println("call userPassword-3");
      Serial.println("OK. Waiting for commands.");
#endif

      client.println("230 OK.");
      return true;
   }
   millisDelay = millis() + FTP_TIME_DELAY;  // delay of FTP_TIME_DELAY ms 服务器暂停 FTP_TIME_DELAY ms
   return false;
}

boolean FtpServer::processCommand()  // 验证客户请求指令
{
#ifdef FTP_DEBUG
   Serial.println("call processCommand");
#endif

   ///////////////////////////////////////
   //                                                                     //
   //            ACCESS CONTROL COMMANDS            //
   //                                                                     //
   ///////////////////////////////////////

   /**
     * CDUP - Change to Parent Directory
     * 回到上一层目录
     * 此命令要求系统实现目录树结构，它的响应和CWD的相同。
     */
   if (!strcmp(command, "CDUP") || (!strcmp(command, "CWD") && !strcmp(parameters, ".."))) {  // 返回上一层目录
#ifdef FTP_DEBUG
      Serial.println("call processCommand-1");
#endif


      bool ok = false;
      if (strlen(cwdName) > 1)  // do nothing if cwdName is root 目录非根目录'/'
      {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-1-1");
#endif


         // if cwdName ends with '/', remove it (must not append)
         if (cwdName[strlen(cwdName) - 1] == '/') {  // 若目录末尾有'/', 移除它
#ifdef FTP_DEBUG
            Serial.println("call processCommand-1-1-1");
#endif

            cwdName[strlen(cwdName) - 1] = 0;
         }
         // search last '/'
         char *pSep = strrchr(cwdName, '/');  // 指向最深的目录或文件前的'/'
         ok         = pSep > cwdName;         // 若合法, ok置为true
         // if found, ends the string on its position
         if (ok) {  // 若合法
#ifdef FTP_DEBUG
            Serial.println("call processCommand-1-1-2");
#endif

            *pSep = 0;                       // 设置c风格字符串的空结束符, 删除最深一级目录
            ok    = SD_MMC.exists(cwdName);  // 查看上一级目录是否存在
         }
      }
      // if an error appends, move to root
      if (!ok) {  // 若上一级目录不存在
#ifdef FTP_DEBUG
         Serial.println("call processCommand-1-2");
#endif

         strcpy(cwdName, "/");  // 当前目录设置为根目录
      }
      // client << F("250 Ok. Current directory is ") << cwdName << eol;

      client.println("250 Ok. Current directory is " + String(cwdName));
   }

   /**
     * CWD - Change Working Directory
     * 改变工作目录
     * 此命令使用户可以在不同的目录或数据集下工作而不用改变它的登录或帐户信息。传输参数也不变。参数一般是目录名或与系统相关的文件集合。
     */
   else if (!strcmp(command, "CWD")) {  // 更改当前工作目录
#ifdef FTP_DEBUG
      Serial.println("call processCommand-2");
#endif

      char path[FTP_CWD_SIZE];
      if (haveParameter() && makeExistsPath(path)) {  // 请求中存在参数且通过参数计算出的目标路径存在
#ifdef FTP_DEBUG
         Serial.println("call processCommand-2-1");
#endif

         strcpy(cwdName, path);  // 将目标路径设置为当前路径
         client.println("250 Ok. Current directory is " + String(cwdName));
      }

      //Serial.print("********************************************cwdName: ");Serial.println(String(cwdName));
      /*
        char path[ FTP_CWD_SIZE ];
        if( strcmp( parameters, "." ) == 0 ){    // 'CWD .' is the same as PWD command
        
            client.println( "257 \"" + String(cwdName) + "\" is your current directory");
            */
      //     Serial.print("********************************************cwdName: ");Serial.println(String(cwdName));
      /*
        }
        else 
            {     
                if( haveParameter() && makeExistsPath( path )){    
                 strcpy( cwdName, path );
                Serial.print("************************parameters: ");Serial.println(parameters);
                
                client.println( "250 Ok. Current directory is " + String(cwdName) );
                 Serial.print("********************************************cwdName: ");Serial.println(String(cwdName));
                }
            }
        */
   }

   /**
     * PWD - Print Directory
     * 打印工作目录
     * 此命令响应并返回当前工作目录。
     */
   else if (!strcmp(command, "PWD")) {  // 返回当前工作目录
#ifdef FTP_DEBUG
      Serial.println("call processCommand-3");
#endif

      client.println("257 \"" + String(cwdName) + "\" is your current directory");
   }

   /**
    * QUIT - Sign Out
    * 退出登录
    * 此命令终止USER，如果没有数据传输，服务器关闭控制连接
    * 如果有数据传输，在得到传输响应后服务器关闭控制连接
    * 如果用户进程正在向不同的USER传输数据，不希望对每个USER关闭然后再打开，可以使用REIN
    * 对控制连接的意外关闭，可以导致服务器运行中止(ABOR)和退出登录(QUIT)。
    */
   else if (!strcmp(command, "QUIT")) {  // 中断连接
#ifdef FTP_DEBUG
      Serial.println("call processCommand-4");
#endif

      disconnectClient();  // 终止数据连接与服务连接
      return false;
   }

   ///////////////////////////////////////
   //                                                                     //
   //        TRANSFER PARAMETER COMMANDS        //
   //                                                                     //
   ///////////////////////////////////////

   /**
     * MODE - Transfer Mode
     * 传输模式
     * 参数是一个Telnet字符代码指定传输模式。下面是代码及其意义：
     * S - 流（默认值）
     * B - 块
     * C - 压缩
     */
   else if (!strcmp(command, "MODE")) {  // 传输模式选择, 只支持流式传输
#ifdef FTP_DEBUG
      Serial.println("call processCommand-5");
#endif

      // stream
      if (!strcmp(parameters, "S")) {
         client.println("200 S Ok");
      }
      // else if( ! strcmp( parameters, "B" ))
      //    client.println( "200 B Ok\r\n";
      else {
         client.println("504 Only S(tream) is suported");
      }
   }

   /**
     * PASV - Passive Connection management
     * 被动
     * 此命令要求服务器DTP在指定的数据端口侦听，进入被动接收请求的状态，参数是主机和端口地址。
     */
   else if (!strcmp(command, "PASV")) {  // 服务器进入被动请求状态
#ifdef FTP_DEBUG
      Serial.println("call processCommand-6");
#endif

      if (data.connected()) {  // 若数据连接还保持连接状态, 先断开连接
#ifdef FTP_DEBUG
         Serial.println("call processCommand-6-1");
#endif

         data.stop();
      }
      //dataServer.begin();
      //dataIp = Ethernet.localIP();

      dataIp   = WiFi.localIP();      // 获得本机IP
      dataPort = FTP_DATA_PORT_PASV;  // 数据端口设置为预设的端口

      //data.connect( dataIp, dataPort );
      //data = dataServer.available();

#ifdef FTP_DEBUG
      Serial.println("Connection management set to passive");
      Serial.println("Data port set to " + String(dataPort));
#endif

      client.println("227 Entering Passive Mode (" + String(dataIp[0]) + "," + String(dataIp[1]) + "," + String(dataIp[2]) + "," + String(dataIp[3]) + "," + String(dataPort >> 8) + "," + String(dataPort & 255) + ").");
      dataPassiveConn = true;  // 设置被动监听的标志
   }

   /**
     * PORT - Data Port
     * 数据端口
     * 参数是要使用的数据连接端口，通常情况下对此不需要命令响应。如果使用此命令时，要发送32位的IP地址和16位的TCP端口号。上面的信息以8位为一组，逗号间隔十进制传输，如下例：
     * PORT h1,h2,h3,h4,p1,p2
     */
   else if (!strcmp(command, "PORT")) {  // 服务器进入主动请求状态
#ifdef FTP_DEBUG
      Serial.println("call processCommand-7");
#endif

      // if (data) {
      if (data.connected()) {  // 若数据连接还保持连接状态, 先断开连接
#ifdef FTP_DEBUG
         Serial.println("call processCommand-7-1");
#endif

         data.stop();
      }
      // get IP of data client
      /* 获得字符串中被分隔的每个整数 */

      //      dataIp[0] = atoi(parameters);  // 获得字符串中第一个整数
      //       char *p = strchr(parameters, ',');
      //       for (uint8_t i = 1; i < 4; i++) {
      //          dataIp[i] = atoi(++p);
      //          p         = strchr(p, ',');
      //       }
      //       // get port of data client
      //       dataPort = 256 * atoi(++p);  // 获得字符串中表示端口的第一个整数
      //       p        = strchr(p, ',');
      //       dataPort += atoi(++p);  // 获得字符串中表示端口的第二个整数
      //       if (p == NULL) {
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-7-2");
      // #endif

      //          client.println("501 Can't interpret parameters");
      //       }
      //       else {
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-7-3");
      // #endif

      //          client.println("200 PORT command successful");
      //          dataPassiveConn = false;  // 关闭被动模式标签
      //       }

      try {
         dataIp[0] = atoi(parameters);  // 获得字符串中第一个整数
         char *p   = strchr(parameters, ',');
         for (uint8_t i = 1; i < 4; i++) {
            dataIp[i] = atoi(++p);
            p         = strchr(p, ',');
         }
         // get port of data client
         dataPort = 256 * atoi(++p);  // 获得字符串中表示端口的第一个整数
         p        = strchr(p, ',');
         dataPort += atoi(++p);  // 获得字符串中表示端口的第二个整数
      }
      catch (...) {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-7-2");
#endif

         client.println("501 Can't interpret parameters");
         return true;
      }

#ifdef FTP_DEBUG
      Serial.println("call processCommand-7-3");
#endif

      client.println("200 PORT command successful");
      dataPassiveConn = false;  // 关闭被动模式标签
   }

   /**
     * STRU - File Structure
     * 文件结构
     * 参数是一个Telnet字符代码指定文件结构。下面是代码及其意义：
     * F - 文件（非记录结构），它是默认值
     * R - 记录结构
     * P - 页结构
     */
   else if (!strcmp(command, "STRU")) {  // 仅支持文件结构
#ifdef FTP_DEBUG
      Serial.println("call processCommand-8");
#endif

      if (!strcmp(parameters, "F")) {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-8-1");
#endif

         client.println("200 F Ok");
      }
      // else if( ! strcmp( parameters, "R" ))
      //    client.println( "200 B Ok\r\n";
      else {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-8-2");
#endif

         client.println("504 Only F(ile) is suported");
      }
   }

   /**
     * TYPE - Data Type
     * 表示类型
     * 参数指定表示类型。有些类型需要第二个参数，第一个参数由单个Telnet字符定义，第二个参数是十进制整数指定字节大小，参数间以<SP>分隔。
     * 默认表示类型是ASCII非打印字符，如果参数未改变，以后只改变了第一个参数，则使用默认值。
     */
   else if (!strcmp(command, "TYPE")) {  // 设置数据传输类型, 支持ascii与bitstream
#ifdef FTP_DEBUG
      Serial.println("call processCommand-9");
#endif

      if (!strcmp(parameters, "A")) {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-9-1");
#endif

         client.println("200 TYPE is now ASII");
      }
      else if (!strcmp(parameters, "I")) {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-9-2");
#endif

         client.println("200 TYPE is now 8-bit binary");
      }
      else {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-9-3");
#endif

         client.println("504 Unknow TYPE");
      }
   }

   ///////////////////////////////////////
   //                                                                     //
   //                FTP SERVICE COMMANDS             //
   //                                                                     //
   ///////////////////////////////////////

   /**
     * ABOR - Abort
     * 放弃
     * 此命令通知服务中止以前的FTP命令和与之相关的数据传送。
     * 如果先前的操作已经完成，则没有动作，返回226。
     * 如果没有完成，返回426，然后再返回226。关闭控制连接，数据连接不关闭。
     */
   else if (!strcmp(command, "ABOR")) {  // 终止数据连接
#ifdef FTP_DEBUG
      Serial.println("call processCommand-10");
#endif

      abortTransfer();
      client.println("226 Data connection closed");
   }

   /**
     * DELE - Delete a File
     * 删除
     * 此命令删除指定路径下的文件。用户进程负责对删除的提示。
     */
   else if (!strcmp(command, "DELE")) {  // 删除指定文件
#ifdef FTP_DEBUG
      Serial.println("call processCommand-11");
#endif

      char path[FTP_CWD_SIZE];
      //       if (strlen(parameters) == 0) {  // 要求有一个路径参数
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-11-1");
      // #endif

      //          client.println("501 No file name");
      //       }
      //       else if (makePath(path)) {  // 生成目标路径
      if (haveParameter() && makePath(path)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-11-2");
#endif

         if (!SD_MMC.exists(path)) {  // 若目标路径不存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-11-2-1");
#endif

            client.println("550 File " + String(parameters) + " not found");
         }
         else {  // 目标路径存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-11-2-2");
#endif

            if (SD_MMC.remove(path)) {  // 删除目标
#ifdef FTP_DEBUG
               Serial.println("call processCommand-11-2-2-1");
#endif

               client.println("250 Deleted " + String(parameters));
            }
            else {  // 删除目标文件失败
#ifdef FTP_DEBUG
               Serial.println("call processCommand-11-2-2-2");
#endif

               client.println("450 Can't delete " + String(parameters));
            }
         }
      }
   }

   /**
     * LIST - List
     * 列表
     * 服务器传送列表到被动DTP，如果路径指定一个目录或许多文件，返回指定路径下的 文件列表。
     * 如果路径名指定一个文件，服务器返回文件的当前信息，参数为空表示用户当前的工作目录或默认目录。
     * 数据传输在ASCII或EBCDIC下进行， 用户必须确认这一点。因为文件信息因系统不同而不同，所以不可能被程序自动利用，但是人类用户却很需要。
     */
   else if (!strcmp(command, "LIST")) {  // 列出当前目录下的文件与次级目录(仅名称)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-12");
#endif

      if (dataConnect()) {  // 是否建立数据连接, 若未建立在尝试建立后返回建立结果
#ifdef FTP_DEBUG
         Serial.println("call processCommand-12-1");
#endif

         client.println("150 Accepted data connection");
         uint16_t nm  = 0;  // 文件/次级目录计数器
         File     dir = SD_MMC.open(cwdName);
         if ((!dir) || (!dir.isDirectory())) {  // 若当前目录打开失败/当前目录不合法
#ifdef FTP_DEBUG
            Serial.println("call processCommand-12-1-1");
#endif

            client.println("550 Can't open directory " + String(cwdName));
         }
         else {  // 当前目录打开成功
#ifdef FTP_DEBUG
            Serial.println("call processCommand-12-1-2");
#endif

            File file = dir.openNextFile();  // 返回当前目录中第一个文件/次级目录
            while (file) {                   // 若当前目录中第一个文件/次级目录存在
               String fn, fs;
               /* 删除前面的路径, 获得该文件/次级目录的名字 */
               fn    = file.name();
               int i = fn.lastIndexOf("/") + 1;
               fn.remove(0, i);

#ifdef FTP_DEBUG
               Serial.println("File Name = " + fn);
#endif

               if (file.isDirectory()) {  // 若为次级目录
                  data.println("01-01-2000    00:00AM <DIR> " + fn);
               }
               else {                        // 若为文件
                  fs = String(file.size());  // 获得该文件的大小
                  data.println("01-01-2000    00:00AM " + fs + " " + fn);
                  //                    data.println( " " + fn );
               }
               nm++;                       // 计数器+1;
               file = dir.openNextFile();  // 获得下一个文件/次级目录
            }
            client.println("226 " + String(nm) + " matches total");
            data.stop();
         }
      }
      else {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-12-2");
#endif

         client.println("425 No data connection");
         data.stop();  // 发送完成后终止数据连接
      }
   }

   /**
     * MLSD - Listing for Machine Processing (see RFC 3659)
     */
   else if (!strcmp(command, "MLSD")) {  // 列出当前目录下的文件与次级目录(仅名称, MLSD方式, 响应格式不同)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-13");
#endif

      if (!dataConnect()) {  // 是否建立数据连接, 若未建立在尝试建立后返回建立结果
#ifdef FTP_DEBUG
         Serial.println("call processCommand-13-1");
#endif

         client.println("425 No data connection MLSD");
      }
      else {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-13-2");
#endif

         client.println("150 Accepted data connection");
         uint16_t nm = 0;  // 文件/次级目录计数器
         //            Dir dir= SD.openDir(cwdName);
         File dir = SD_MMC.open(cwdName);
         char dtStr[15];
         //    if(!SD.exists(cwdName))
         if ((!dir) || (!dir.isDirectory())) {  // 若当前目录打开失败/当前目录不合法
#ifdef FTP_DEBUG
            Serial.println("call processCommand-13-2-1");
#endif

            client.println("550 Can't open directory " + String(cwdName));
            // client.println( "550 Can't open directory " +String(parameters) );
         }
         else {  // 当前目录打开成功
#ifdef FTP_DEBUG
            Serial.println("call processCommand-13-2-2");
#endif

            //                while( dir.next())
            File file = dir.openNextFile();  // 返回当前目录中第一个文件/次级目录
            //                while( dir.openNextFile())
            while (file) {  // 若当前目录中第一个文件/次级目录存在
               String fn, fs;
               fn      = file.name();
               int pos = fn.lastIndexOf("/");  //ищем начало файла по последнему "/"
               fn.remove(0, pos + 1);          //Удаляем все до имени файла включительно
               if (file.isDirectory()) {       // 若为次级目录
                  data.println(fn);
                  //                        data.println( "Type=dir;Size=" + fs + ";"+"modify=20000101000000;" +" " + fn);
                  //                        data.println( "Type=dir;modify=20000101000000; " + fn);
               }
               else {                        // 若为文件
                  fs = String(file.size());  // 获得该文件的大小
                  data.println(fs + " " + fn);
                  //data.println( "Type=file;Size=" + fs + ";"+"modify=20000101160656;" +" " + fn);
                  //data.println( "Type=file;Size=" + fs + ";"+"modify=20000101000000;" +" " + fn);
               }
               nm++;                       // 计数器+1;
               file = dir.openNextFile();  // 获得下一个文件/次级目录
            }
            client.println("226-options: -a -l");
            client.println("226 " + String(nm) + " matches total");
         }
         data.stop();
      }
   }

   /**
     * NLST - Name List
     * 名字列表
     * 服务器传送目录表名到用户，路径名应指定目录或其它系统指定的文件群描述子；空参数指当前目录。
     * 服务器返回文件名数据流，以ASCII或EBCDIC形式传送，并以<CRLF>或<NL>分隔。这里返回的信息有时可以供程序进行进一步处理。
     */
   else if (!strcmp(command, "NLST")) {  // 返回当前目录的文件/次级目录(包含绝对路径的名称)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-14");
#endif

      if (!dataConnect()) {  // 检查数据连接
#ifdef FTP_DEBUG
         Serial.println("call processCommand-14-1");
#endif

         client.println("425 No data connection");
      }
      else {
#ifdef FTP_DEBUG
         Serial.println("call processCommand-14-2");
#endif

         client.println("150 Accepted data connection");
         uint16_t nm = 0;
         // Dir dir=SD.openDir(cwdName);
         // File dir = SD_MMC.open(cwdName);
         if (!SD_MMC.exists(cwdName)) {  // 当前目录不存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-14-2-1");
#endif

            client.println("550 Can't open directory " + String(parameters));
         }
         else {  // 当前目录存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-14-2-2");
#endif
            File dir  = SD_MMC.open(cwdName);
            File file = dir.openNextFile();
            //                while( dir.next())
            while (file) {  // 使用<CRLF>("\r\n")分隔
               //                    data.println( dir.fileName());
               data.println(file.name());
               nm++;
               file = dir.openNextFile();
            }
            client.println("226 " + String(nm) + " matches total");
         }
         data.stop();
      }
   }

   /**
     * NOOP
     * 等待
     * 此命令不产生什么实际动作，它仅使服务器返回OK。
     */
   else if (!strcmp(command, "NOOP")) {  // 服务器等待
#ifdef FTP_DEBUG
      Serial.println("call processCommand-15");
#endif

      // dataPort = 0;
      client.println("200 Zzz...");
   }

   /**
     * RETR - Retrieve
     * 获得文件
     * 此命令使服务器DTP传送指定路径内的文件复本到服务器或用户DTP。这边服务器上文件的状态和内容不受影响。
     */
   else if (!strcmp(command, "RETR")) {  // 下载文件(原文件保持不变)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-16");
#endif

      char path[FTP_CWD_SIZE];
      //       if (strlen(parameters) == 0) {
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-16-1");
      // #endif

      //          client.println("501 No file name");
      //       }
      //       else if (makePath(path)) {  // 生成目标绝对路径
      if (haveParameter() && makePath(path)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-16-2");
#endif

         if (SD_MMC.exists(path)) {  // 目标是否存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-1");
#endif

            client.println("550 File " + String(parameters) + " not found");
            return true;
         }
         file = SD_MMC.open(path, "r");
         if (!file) {  // 文件未成功打开
#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-2");
#endif

            client.println("450 Can't open " + String(parameters));
         }
         else if (!dataConnect()) {  // 数据连接未建立
#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-3");
#endif

            client.println("425 No data connection");
         }
         else {  // 文件下载已准备好
#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-4");
            Serial.println("Sending " + String(parameters));
#endif

            client.println("150-Connected to port " + String(dataPort));
            client.println("150 " + String(file.size()) + " bytes to download");
            millisBeginTrans = millis();
            bytesTransfered  = 0;  // 已传输字节计数器清零
            transferStatus   = 1;  // 设置数据传输状态为下载
         }
      }
   }

   /**
     * STOR - Store
     * 保存
     * 此命令使服务器DTP接收数据连接上传送过来的数据，并将数据保存在服务器的文件中。如果文件已存在，原文件将被覆盖。如果文件不存在，则新建文件。
     */
   else if (!strcmp(command, "STOR")) {  // 上传文件(会覆盖原文件)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-17");
#endif

      char path[FTP_CWD_SIZE];
      //       if (strlen(parameters) == 0) {  // 请求参数中没有该文件的储存路径与文件名
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-17-1");
      // #endif

      //          client.println("501 No file name");
      //       }
      //       else if (makePath(path)) {  // 生成目标路径
      if (haveParameter() && makePath(path)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-17-2");
#endif

         file = SD_MMC.open(path, "w");
         if (!file) {  // 文件打开失败
#ifdef FTP_DEBUG
            Serial.println("call processCommand-17-2-1");
#endif

            client.println("451 Can't open/create " + String(parameters));
         }
         else if (!dataConnect()) {  // 数据未连接
#ifdef FTP_DEBUG
            Serial.println("call processCommand-17-2-2");
#endif

            client.println("425 No data connection");
            file.close();
         }
         else {  // 文件上传已准备好
#ifdef FTP_DEBUG
            Serial.println("call processCommand-17-2-3");
            Serial.println("Receiving " + String(parameters));
#endif

            client.println("150 Connected to port " + String(dataPort));
            millisBeginTrans = millis();  // 更新文件上传开始时间
            bytesTransfered  = 0;         // 已传输字节计数器清零
            transferStatus   = 2;         // 文件传输状态设置为上传
         }
      }
   }

   /**
     * MKD - Make Directory
     * 创建目录
     * 此命令在指定路径下创建新目录。
     */
   else if (!strcmp(command, "MKD")) {  // 在指定路径下创建新目录
#ifdef FTP_DEBUG
      Serial.println("call processCommand-18");
#endif

      char path[FTP_CWD_SIZE];
      if (haveParameter() && makePath(path)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-18-1");
#endif

         if (SD_MMC.exists(path)) {  // 目标路径已存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-18-1-1");
#endif

            client.println("521 Can't create \"" + String(parameters) + ", Directory exists");
         }
         else {  // 目标路径不存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-18-1-2");
#endif

            if (SD_MMC.mkdir(path)) {  // 创目录成功
#ifdef FTP_DEBUG
               Serial.println("call processCommand-18-1-2-1");
#endif

               client.println("257 \"" + String(parameters) + "\" created");
            }
            else {  // 创建目录失败
#ifdef FTP_DEBUG
               Serial.println("call processCommand-18-1-2-2");
#endif

               client.println("550 Can't create \"" + String(parameters));
            }
         }
      }
   }

   /**
     * RMD - Remove a Directory
     * 删除目录
     * 此命令删除目录。
     */
   else if (!strcmp(command, "RMD")) {  // 删除指定目录
#ifdef FTP_DEBUG
      Serial.println("call processCommand-19");
#endif

      char path[FTP_CWD_SIZE];
      if (haveParameter() && makePath(path)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-19-1");
#endif

         if (SD_MMC.rmdir(path)) {  // 删除目录成功
#ifdef FTP_DEBUG
            Serial.println("call processCommand-19-1-1");
            Serial.println(" Deleting " + String(parameters));
#endif

            client.println("250 \"" + String(parameters) + "\" deleted");
         }
         else {  // 删除目录失败
#ifdef FTP_DEBUG
            Serial.println("call processCommand-19-1-2");
#endif

            client.println("550 Can't remove \"" + String(parameters) + "\". Directory not empty?");
         }
      }
   }

   /**
     * RNFR - Rename From
     * 重命名
     * 这个命令和我们在其它操作系统中使用的一样，只不过后面要跟"rename to"指定新的文件名。
     */
   else if (!strcmp(command, "RNFR")) {  // 重命名指定文件/目录(也可以用于移动文件/目录)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-20");
#endif

      buf[0] = 0;  // 用于储存重命名目标的路径
      //       if (strlen(parameters) == 0) {
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-20-1");
      // #endif

      //          client.println("501 No file name");
      //       }
      //       else if (makePath(buf)) {
      if (haveParameter() && makePath(buf)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-20-2");
#endif

         if (!SD_MMC.exists(buf)) {  // 目标路径不存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-20-2-1");
#endif

            client.println("550 File " + String(parameters) + " not found");
         }
         else {  // 目标路径存在
#ifdef FTP_DEBUG
            Serial.println("call processCommand-20-2-2");
            Serial.println("Renaming " + String(buf));
#endif

            client.println("350 RNFR accepted - file exists, ready for destination");
            rnfrCmd = true;  // 成功解析RNFR命令的标志
         }
      }
   }

   /**
     * RNTO - Rename To
     * 重命名为
     * 此命令和上面的命令共同完成对文件的重命名。
     */
   else if (!strcmp(command, "RNTO")) {  // 重命名文件/目录为(也可以是移动文件/目录的目标路径)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-21");
#endif

      char path[FTP_CWD_SIZE];
      char dir[FTP_FIL_SIZE];
      if (strlen(buf) == 0 || !rnfrCmd) {  // 重命名指令RNFR未成功解析
#ifdef FTP_DEBUG
         Serial.println("call processCommand-21-1");
#endif

         client.println("503 Need RNFR before RNTO");
      }
      //       else if (strlen(parameters) == 0) {
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-21-2");
      // #endif

      //          client.println("501 No file name");
      //       }
      //       else if (makePath(path)) {
      else if (haveParameter() && makePath(path)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-21-3");
#endif

         if (SD_MMC.exists(path)) {  // 目标路径有效, 说明会发生重名
#ifdef FTP_DEBUG
            Serial.println("call processCommand-21-3-1");
#endif

            client.println("553 " + String(parameters) + " already exists");
         }
         else {  // 目标路径无效, 不会发生重名
#ifdef FTP_DEBUG
            Serial.println("call processCommand-21-3-2");
            Serial.println("Renaming " + String(buf) + " to " + String(path));
#endif

            if (SD_MMC.rename(buf, path)) {  // 重命名/移动成功
#ifdef FTP_DEBUG
               Serial.println("call processCommand-21-3-2-1");
#endif

               client.println("250 File successfully renamed or moved");
            }
            else {  // 重命名/移动失败
#ifdef FTP_DEBUG
               Serial.println("call processCommand-21-3-2-2");
#endif

               client.println("451 Rename/move failure");
            }
         }
      }
      rnfrCmd = false;
   }

   ///////////////////////////////////////
   //                                                                     //
   //     EXTENSIONS COMMANDS (RFC 3659)    //
   //                                                                     //
   ///////////////////////////////////////

   /**
     * FEAT - New Features
     * 获取支持的高级功能
     */
   else if (!strcmp(command, "FEAT")) {  // 获取支持的高级功能(仅支持MLSD)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-22");
#endif

      client.println("211-Extensions suported:");
      client.println(" MLSD");
      client.println("211 End.");
   }

   /**
     * MDTM - File Modification Time (see RFC 3659)
     * 获取文件修改时间
     */
   else if (!strcmp(command, "MDTM")) {  // 获取文件修改时间(不支持)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-23");
#endif

      client.println("550 Unable to retrieve time");
   }

   /**
     * SIZE - Size of the file
     * 获取文件大小
     */
   else if (!strcmp(command, "SIZE")) {  // 获取文件大小(支持)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-24");
#endif

      char path[FTP_CWD_SIZE];
      //       if (strlen(parameters) == 0) {
      // #ifdef FTP_DEBUG
      //          Serial.println("call processCommand-24-1");
      // #endif

      //          client.println("501 No file name");
      //       }
      //       else if (makePath(path)) {
      if (haveParameter() && makePath(path)) {  // 检查参数并生成目标路径
#ifdef FTP_DEBUG
         Serial.println("call processCommand-24-2");
#endif

         file = SD_MMC.open(path, "r");
         if (!file) {  // 图片未成功访问
#ifdef FTP_DEBUG
            Serial.println("call processCommand-24-2-1");
#endif

            client.println("450 Can't open " + String(parameters));
         }
         else {  // 图片成功访问
#ifdef FTP_DEBUG
            Serial.println("call processCommand-24-2-2");
#endif

            client.println("213 " + String(file.size()));
            file.close();
         }
      }
   }

   /**
     * SITE - System command
     * 系统设置
     */
   else if (!strcmp(command, "SITE")) {  // 进行系统设置(不支持)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-25");
#endif

      client.println("500 Unknow SITE command " + String(parameters));
   }

   /**
     * Unrecognized commands ...
     * 其他未知请求类型
     */
   else {  // 其他位置请求类型(不支持)
#ifdef FTP_DEBUG
      Serial.println("call processCommand-26");
#endif

      client.println("500 Unknow command");
   }

   return true;
}

boolean FtpServer::dataConnect()  // 进行数据连接
{
#ifdef FTP_DEBUG
   Serial.println("call dataConnect");
#endif

   unsigned long startTime = millis();
   //wait 5 seconds for a data connection
   if (!data.connected()) {  // 若数据传输端口未连接
#ifdef FTP_DEBUG
      Serial.println("call dataConnect-1");
#endif

      while (!dataServer.hasClient() && millis() - startTime < 10000)  // 若超时前接收到客户的连接请求, 跳出循环
      //        while (!dataServer.available() && millis() - startTime < 10000)
      {
         //delay(100);
         yield();
      }
      if (dataServer.hasClient()) {  // 若接收到客户的连接请求
#ifdef FTP_DEBUG
         Serial.println("call dataConnect-1-1");
#endif

         //        if (dataServer.available()) {
         data.stop();                    // 终止之前的数据连接
         data = dataServer.available();  // 与新的客户建立数据连接

#ifdef FTP_DEBUG
         Serial.println("ftpdataserver client....");
#endif
      }
   }

   return data.connected();  // 返回现在是否成功建立数据连接
}

boolean FtpServer::doRetrieve()  // 下载文件的中的一块数据, 文件下载完全完成后返回false
{
#ifdef FTP_DEBUG
   Serial.println("call doRetrieve");
#endif


   if (data.connected()) {  // 数据连接正常
#ifdef FTP_DEBUG
      Serial.println("call doRetrieve-1");
#endif

      int16_t nb = file.readBytes(buf, FTP_BUF_SIZE);  // 读取目标文件一块最大为FTP_BUF_SIZE字节的数据, 读取失败或读到文件结尾返回-1, 读取成功返回读取的字节数
      if (nb > 0) {                                    // 成功读取一块
#ifdef FTP_DEBUG
         Serial.println("call doRetrieve-1-1");
#endif

         data.write((uint8_t *)buf, nb);  // 发送这块数据
         bytesTransfered += nb;           // 统计已发送的数据(单位: z)
         return true;
      }
   }
   /* 数据已全部传输完成/数据连接不正常/未成功读取一块数据 */
   closeTransfer();  // 终止数据传输
   return false;     // 重置传输状态
}

boolean FtpServer::doStore()  // 上传文件的中的一块数据, 文件上传完全完成后返回false
{
#ifdef FTP_DEBUG
   Serial.println("call doStore");
#endif


   if (data.connected()) {  // 数据连接正常
#ifdef FTP_DEBUG
      Serial.println("call doStore-1");
#endif

      int16_t nb = data.readBytes((uint8_t *)buf, FTP_BUF_SIZE);  // 读取目标文件一块最大为FTP_BUF_SIZE字节的数据, 读取失败或读到文件结尾返回-1, 读取成功返回读取的字节数
      if (nb > 0) {
#ifdef FTP_DEBUG
         Serial.println("call doStore-1-1");
#endif

         // Serial.println( millis() << " " << nb << endl;
         file.write((uint8_t *)buf, nb);  // 发送这块数据
         bytesTransfered += nb;           // 统计已发送的数据(单位: 字节)
      }
      return true;
   }
   closeTransfer();  // 终止数据传输
   return false;     // 重置传输状态
}

void FtpServer::closeTransfer()  // 数据传输完成, 传输活动终止
{
#ifdef FTP_DEBUG
   Serial.println("call closeTransfer");
#endif


   uint32_t deltaT = (int32_t)(millis() - millisBeginTrans);
   if (deltaT > 0 && bytesTransfered > 0) {  // 传输数据量与传输用时有效, 计算并打印数据传输速度
#ifdef FTP_DEBUG
      Serial.println("call closeTransfer-1");
#endif

      client.println("226-File successfully transferred");
      client.println("226 " + String(deltaT) + " ms, " + String(bytesTransfered / deltaT) + " kbytes/s");
   }
   else {  // 传输数据量与传输用时无效, 不打印数据传输速度
#ifdef FTP_DEBUG
      Serial.println("call closeTransfer-2");
#endif

      client.println("226 File successfully transferred");
   }

   file.close();  // 文件关闭
   data.stop();   // 数据传输连接关闭
}

void FtpServer::abortTransfer()  // 数据传输活动因意外终止
{
#ifdef FTP_DEBUG
   Serial.println("call abortTransfer");
#endif


   if (transferStatus > 0) {  // 处于数据传输过程中
#ifdef FTP_DEBUG
      Serial.println("call abortTransfer-1");
#endif

      file.close();  // 文件关闭
      data.stop();   // 数据传输连接关闭
      client.println("426 Transfer aborted");

#ifdef FTP_DEBUG
      Serial.println("Transfer aborted!");
#endif
   }
   transferStatus = 0;  // 传输状态重置为默认状态
}
/**
 * Read a char from client connected to ftp server
 * 从FTP连接中读取请求行的一个字符
 *    update cmdLine and command buffers, iCL and parameters pointers
 *
 *    return:
 *        -2 if buffer cmdLine is full
 *        -1 if line not completed
 *         0 if empty line received
 *        length of cmdLine (positive) if no empty line received
 */
int8_t FtpServer::readChar()
{
#ifdef FTP_DEBUG
   Serial.println("call readChar");
#endif


   int8_t rc = -1;  // 返回值初始化为-1

   if (client.available()) {  // 若客户端消息缓存不为空
#ifdef FTP_DEBUG
      Serial.println("call readChar-1");
#endif

      char c = client.read();  // 读一个字符
                               // char c;
                               // client.readBytes((uint8_t*) c, 1);

#ifdef FTP_DEBUG
      // Serial.print(c);
#endif

      if (c == '\\') {  // 统一使用'/'作为分隔符
#ifdef FTP_DEBUG
         Serial.println("call readChar-1-1");
#endif

         c = '/';
      }
      if (c != '\r') {
#ifdef FTP_DEBUG
         Serial.println("call readChar-1-2");
#endif

         if (c != '\n') {  // 若不为换行标志"\r\n"
#ifdef FTP_DEBUG
            Serial.println("call readChar-1-2-1");
#endif

            if (iCL < FTP_CMD_SIZE) {  // 未超过指令长度限制
#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-1-1");
#endif

               cmdLine[iCL++] = c;  // 存入命令行
            }
            else {
#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-1-2");
#endif

               rc = -2;  //    Line too long 超过指令长度限制
            }
         }
         else {  // 若为'\n', 已到行末
#ifdef FTP_DEBUG
            Serial.println("call readChar-1-2-2");
#endif

            cmdLine[iCL] = 0;     // c风格字符串以'\0'结束
            command[0]   = 0;     // 到达行位, 需要接收新的请求, 请求类型置空
            parameters   = NULL;  // 重置参数首指针

#ifdef FTP_LOG
            Serial.printf("request: %s\n", cmdLine);
#endif

            // empty line?
            if (iCL == 0) {  // 命令行是空的, 请求无效
#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-2-1");
#endif

               rc = 0;  // 返回值设为命令行的长度
            }
            else {  // 命令行非空
#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-2-2");
#endif

               rc = iCL;  // 返回值设为命令行的长度
               // search for space between command and parameters
               parameters = strchr(cmdLine, ' ');  // 查找字符首次出现, 指向该点的指针便是请求命令后方参数前一个空格
               if (parameters != NULL) {           // 若存在空格
#ifdef FTP_DEBUG
                  Serial.println("call readChar-1-2-2-2-1");
#endif

                  if (parameters - cmdLine > 4) {  // 若请求命令大于四个字符
#ifdef FTP_DEBUG
                     Serial.println("call readChar-1-2-2-2-1-1");
#endif

                     rc = -2;  // Syntax error 格式错误
                  }
                  else {  // 请求命令长度合法
#ifdef FTP_DEBUG
                     Serial.println("call readChar-1-2-2-2-1-2");
#endif

                     strncpy(command, cmdLine, parameters - cmdLine);  // 将请求命令保存到"command"
                     command[parameters - cmdLine] = 0;                // 为c风格字符串"command"最后添加空字符

                     while (*(++parameters) == ' ')  // 将参数指针指向参数第一个非空格字符
                        ;
                  }
               }
               else if (strlen(cmdLine) > 4) {  // 若不存在空格(该命令无参数), 但是请求命令长度依然大于4
#ifdef FTP_DEBUG
                  Serial.println("call readChar-1-2-2-2-2");
#endif

                  rc = -2;  // Syntax error. 格式错误
               }
               else {  // 无参数命令
#ifdef FTP_DEBUG
                  Serial.println("call readChar-1-2-2-2-3");
#endif

                  strcpy(command, cmdLine);  // 将请求命令保存到"command"
               }
               iCL = 0;  // 该行信息处理完成, 写指针指向"cmdLine"第0个字符处(复位)
            }
         }
      }
      if (rc > 0) {  // 请求命令长度正常
#ifdef FTP_DEBUG
         Serial.println("call readChar-1-3");
#endif

         for (uint8_t i = 0; i < strlen(command); i++) { command[i] = toupper(command[i]); }  // 请求命令全部转换为大写字符
      }
      if (rc == -2) {  // 请求格式错误
#ifdef FTP_DEBUG
         Serial.println("call readChar-1-4");
#endif

         iCL = 0;  // 该行信息错误, 写指针复位
         client.println("500 Syntax error");
      }
   }
   return rc;  // 返回请求行分析结果
}

/**
 * Make complete path/name from cwdName and parameters
 * 通过cwdName与parameters生成完整路径
 * 3 possible cases: parameters can be absolute path, relative path or only the name
 * 参数(parameters)可能是绝对路径/相对路径/名称中的一种
 * @parameters:
 *     fullName : where to store the path/name
 *
 * @return:
 *        true, if done
 */
boolean FtpServer::makePath(char *fullName)  // 计算出目标路径, 默认为请求中的参数为目标
{
#ifdef FTP_DEBUG
   Serial.println("call makePath");
#endif


   return makePath(fullName, parameters);
}

boolean FtpServer::makePath(char *fullName, char *param)  // 计算出目标路径
{
#ifdef FTP_DEBUG
   Serial.println("call makePath");
#endif

   if (param == NULL) {  // 若参数param为空, 设为请求命令中的参数parameters
#ifdef FTP_DEBUG
      Serial.println("call makePath-1");
#endif

      param = parameters;
   }

   // Root or empty?
   if (strcmp(param, "/") == 0 ||  // 参数为根目录
       strlen(param) == 0) {       // 参数为空
#ifdef FTP_DEBUG
      Serial.println("call makePath-2");
#endif

      strcpy(fullName, "/");  // 路径设为根目录
      return true;
   }
   // If relative path, concatenate with current dir
   if (param[0] != '/') {  // 参数为相对路径
#ifdef FTP_DEBUG
      Serial.println("call makePath-3");
#endif

      /* 相对路径与当前路径拼接, 形成目标的绝对路径 */
      strcpy(fullName, cwdName);                    // 当前路径复制到结果字符串
      if (fullName[strlen(fullName) - 1] != '/') {  // 若当前路径末尾不为'/'
#ifdef FTP_DEBUG
         Serial.println("call makePath-1-1");
#endif

         strncat(fullName, "/", FTP_CWD_SIZE);  // 先追加上'/'
      }
      strncat(fullName, param, FTP_CWD_SIZE);  // 将相对路径追加到结果字符串
   }
   else {  // 参数为绝对路径
#ifdef FTP_DEBUG
      Serial.println("call makePath-4");
#endif

      strcpy(fullName, param);  // 直接将绝对路径复制到结果字符串
   }
   // If ends with '/', remove it
   uint16_t strl = strlen(fullName) - 1;
   if (fullName[strl] == '/' && strl > 1) {  // 移除非根目录路径的末尾可能存在的'/'
#ifdef FTP_DEBUG
      Serial.println("call makePath-5");
#endif

      fullName[strl] = 0;
   }
   if (strlen(fullName) < FTP_CWD_SIZE) {  // 若目标路径长度合法
#ifdef FTP_DEBUG
      Serial.println("call makePath-6");
#endif

      return true;
   }

   client.println("500 Command line too long");
   return false;
}

/**
 * Calculate year, month, day, hour, minute and second
 *     from first parameter sent by MDTM command (YYYYMMDDHHMMSS)
 * 获取当前日期与时间(未使用)
 * @parameters:
 *     pyear, pmonth, pday, phour, pminute and psecond: pointer of
 *         variables where to store data
 *
 * @return:
 *        0 if parameter is not YYYYMMDDHHMMSS
 *        length of parameter + space
 */
uint8_t FtpServer::getDateTime(uint16_t *pyear,
                               uint8_t * pmonth,
                               uint8_t * pday,
                               uint8_t * phour,
                               uint8_t * pminute,
                               uint8_t * psecond)
{
#ifdef FTP_DEBUG
   Serial.println("call getDateTime");
#endif


   char dt[15];

   // Date/time are expressed as a 14 digits long string
   //     terminated by a space and followed by name of file
   if (strlen(parameters) < 15 || parameters[14] != ' ') {
#ifdef FTP_DEBUG
      Serial.println("call getDateTime-1");
#endif

      return 0;
   }
   for (uint8_t i = 0; i < 14; i++) {
      if (!isdigit(parameters[i])) { return 0; }
   }

   strncpy(dt, parameters, 14);
   dt[14]   = 0;
   *psecond = atoi(dt + 12);
   dt[12]   = 0;
   *pminute = atoi(dt + 10);
   dt[10]   = 0;
   *phour   = atoi(dt + 8);
   dt[8]    = 0;
   *pday    = atoi(dt + 6);
   dt[6]    = 0;
   *pmonth  = atoi(dt + 4);
   dt[4]    = 0;
   *pyear   = atoi(dt);
   return 15;
}
/**
 * Create string YYYYMMDDHHMMSS from date and time
 * 生成日期与时间字符串(未使用)
 * @parameters:
 *        date, time
 *        tstr: where to store the string. Must be at least 15 characters long
 *
 * @return:
 *        pointer to tstr
 */
char *FtpServer::makeDateTimeStr(char *tstr, uint16_t date, uint16_t time)
{
#ifdef FTP_DEBUG
   Serial.println("call makeDateTimeStr");
#endif


   sprintf(tstr, "%04u%02u%02u%02u%02u%02u",
           ((date & 0xFE00) >> 9) + 1980, (date & 0x01E0) >> 5, date & 0x001F,
           (time & 0xF800) >> 11, (time & 0x07E0) >> 5, (time & 0x001F) << 1);
   return tstr;
}

bool FtpServer::haveParameter()  // 判断请求中是否存在参数
{
#ifdef FTP_DEBUG
   Serial.println("call haveParameter");
#endif


   if (parameters != NULL && strlen(parameters) > 0) {
#ifdef FTP_DEBUG
      Serial.println("call haveParameter-1");
#endif

      return true;
   }
   client.println("501 No file name");
   return false;
}

bool FtpServer::makeExistsPath(char *path, char *param)  // 计算出目标路径, 并判断目标路径是否存在, param默认为NULL
{
#ifdef FTP_DEBUG
   Serial.println("call makeExistsPath");
#endif

   if (!makePath(path, param)) {  // 计算出目标路径, 储存在path
#ifdef FTP_DEBUG
      Serial.println("call makeExistsPath-1");
#endif

      return false;
   }
   if (SD_MMC.exists(path)) {  // 若目标路径存在
#ifdef FTP_DEBUG
      Serial.println("call makeExistsPath-2");
#endif

      return true;
   }
   client.println("550 " + String(path) + " not found.");

   return false;
}
