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
#include <SD_MMC.h>
#include <FS.h>
//#include "SPI.h"

WiFiServer ftpServer(FTP_CTRL_PORT);
WiFiServer dataServer(FTP_DATA_PORT_PASV);

// fs::FS &convertor(fs::FS &fs) {return fs;}

void FtpServer::begin(String uname, String pword)
{
   // Tells the ftp server to begin listening for incoming connection
   _FTP_USER = uname;
   _FTP_PASS = pword;

   ftpServer.begin();
   delay(10);
   dataServer.begin();
   delay(10);
   millisTimeOut = (uint32_t)FTP_TIME_OUT * 60 * 1000;
   millisDelay   = 0;
   cmdStatus     = 0;
   iniVariables();
}

void FtpServer::iniVariables()
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
   transferStatus = 0;
}

void FtpServer::handleFTP()
{

#ifdef FTP_DEBUG
   Serial.println("call handleFTP");
#endif


   if ((int32_t)(millisDelay - millis()) > 0) {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-1");
#endif

      return;
   }

   if (ftpServer.hasClient()) {
      //    if (ftpServer.available()) {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-2");
#endif

      client.stop();
      client = ftpServer.available();
   }

   if (cmdStatus == 0) {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-3");
#endif

      if (client.connected()) {

#ifdef FTP_DEBUG
         Serial.println("call handleFTP-3-1");
#endif

         disconnectClient();
      }
      cmdStatus = 1;
   }
   else if (cmdStatus == 1)  // Ftp server waiting for connection
   {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-4");
#endif

      abortTransfer();
      iniVariables();

#ifdef FTP_DEBUG
      Serial.println("Ftp server waiting for connection on port " + String(FTP_CTRL_PORT));
#endif


      cmdStatus = 2;
   }
   else if (cmdStatus == 2)  // Ftp server idle
   {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-5");
#endif

      if (client.connected())  // A client connected
      {

#ifdef FTP_DEBUG
         Serial.println("call handleFTP-5-1");
#endif

         clientConnected();
         millisEndConnection = millis() + 10 * 1000;  // wait client id during 10 s.
         cmdStatus           = 3;
      }
   }
   else if (readChar() > 0)  // got response
   {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-6");
#endif

      if (cmdStatus == 3) {  // Ftp server waiting for user identity

#ifdef FTP_DEBUG
         Serial.println("call handleFTP-6-1");
#endif

         if (userIdentity()) {

#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-1-1");
#endif

            cmdStatus = 4;
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-1-2");
#endif

            cmdStatus = 0;
         }
      }
      else if (cmdStatus == 4)  // Ftp server waiting for user registration
      {

#ifdef FTP_DEBUG
         Serial.println("call handleFTP-6-2");
#endif

         if (userPassword()) {

#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-2-1");
#endif

            cmdStatus           = 5;
            millisEndConnection = millis() + millisTimeOut;
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-2-2");
#endif

            cmdStatus = 0;
         }
      }
      else if (cmdStatus == 5)  // Ftp server waiting for user command
      {

#ifdef FTP_DEBUG
         Serial.println("call handleFTP-6-3");
#endif

         if (!processCommand()) {

#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-3-1");
#endif

            cmdStatus = 0;
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call handleFTP-6-3-2");
#endif

            millisEndConnection = millis() + millisTimeOut;
         }
      }
   }
   else if (!client.connected() || !client) {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-7");
#endif

      cmdStatus = 1;

#ifdef FTP_DEBUG
      Serial.println("client disconnected");
#endif

   }

   if (transferStatus == 1)  // Retrieve data
   {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-8");
#endif

      if (!doRetrieve()) { transferStatus = 0; }
   }
   else if (transferStatus == 2)  // Store data
   {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-9");
#endif

      if (!doStore()) {

#ifdef FTP_DEBUG
         Serial.println("call handleFTP-9-1");
#endif

         transferStatus = 0;
      }
   }
   else if (cmdStatus > 2 && !((int32_t)(millisEndConnection - millis()) > 0)) {

#ifdef FTP_DEBUG
      Serial.println("call handleFTP-10");
#endif

      client.println("530 Timeout");
      millisDelay = millis() + 200;  // delay of 200 ms
      cmdStatus   = 0;
   }
}

void FtpServer::clientConnected()
{

#ifdef FTP_DEBUG
   Serial.println("Client connected!");
#endif

   client.println("220--- Welcome to FTP for ESP8266 ---");
   client.println("220---     By David Paiva     ---");
   client.println("220 --     Version " + String(FTP_SERVER_VERSION) + "     --");
   iCL = 0;
}

void FtpServer::disconnectClient()
{

#ifdef FTP_DEBUG
   Serial.println(" Disconnecting client");
#endif

   abortTransfer();
   client.println("221 Goodbye");
   client.stop();
}

boolean FtpServer::userIdentity()
{

#ifdef FTP_DEBUG
   Serial.println("call userIdentity");
#endif


   if (strcmp(command, "USER")) {

#ifdef FTP_DEBUG
      Serial.println("call userIdentity-1");
#endif

      client.println("500 Syntax error");
   }
   if (strcmp(parameters, _FTP_USER.c_str())) {

#ifdef FTP_DEBUG
      Serial.println("call userIdentity-2");
#endif


      client.println("530 user not found");
   }
   else {

#ifdef FTP_DEBUG
      Serial.println("call userIdentity-3");
#endif


      client.println("331 OK. Password required");
      strcpy(cwdName, "/");
      return true;
   }
   millisDelay = millis() + 100;  // delay of 100 ms
   return false;
}

boolean FtpServer::userPassword()
{

#ifdef FTP_DEBUG
   Serial.println("call userPassword");
#endif


   if (strcmp(command, "PASS")) {

#ifdef FTP_DEBUG
      Serial.println("call userPassword-1");
#endif


      client.println("500 Syntax error");
   }
   else if (strcmp(parameters, _FTP_PASS.c_str())) {

#ifdef FTP_DEBUG
      Serial.println("call userPassword-2");
#endif


      client.println("530 ");
   }
   else {

#ifdef FTP_DEBUG
      Serial.println("call userPassword-3");
      Serial.println("OK. Waiting for commands.");
#endif

      client.println("230 OK.");
      return true;
   }
   millisDelay = millis() + 100;  // delay of 100 ms
   return false;
}

boolean FtpServer::processCommand()
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
   if (!strcmp(command, "CDUP") || (!strcmp(command, "CWD") && !strcmp(parameters, ".."))) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-1");
#endif


      bool ok = false;
      if (strlen(cwdName) > 1)  // do nothing if cwdName is root
      {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-1-1");
#endif


         // if cwdName ends with '/', remove it (must not append)
         if (cwdName[strlen(cwdName) - 1] == '/') {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-1-1-1");
#endif

            cwdName[strlen(cwdName) - 1] = 0;
         }
         // search last '/'
         char *pSep = strrchr(cwdName, '/');
         ok         = pSep > cwdName;
         // if found, ends the string on its position
         if (ok) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-1-1-2");
#endif

            *pSep = 0;
            ok    = SD_MMC.exists(cwdName);
         }
      }
      // if an error appends, move to root
      if (!ok) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-1-2");
#endif

         strcpy(cwdName, "/");
      }
      // client << F("250 Ok. Current directory is ") << cwdName << eol;

      client.println("250 Ok. Current directory is " + String(cwdName));
   }

   /**
     * CWD - Change Working Directory
     * 改变工作目录
     * 此命令使用户可以在不同的目录或数据集下工作而不用改变它的登录或帐户信息。传输参数也不变。参数一般是目录名或与系统相关的文件集合。
     */
   else if (!strcmp(command, "CWD")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-2");
#endif


      char path[FTP_CWD_SIZE];
      if (haveParameter() && makeExistsPath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-2-1");
#endif

         strcpy(cwdName, path);
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
   else if (!strcmp(command, "PWD")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-3");
#endif

      client.println("257 \"" + String(cwdName) + "\" is your current directory");
   }

   /**
    * QUIT - Sign Out
    * 退出登录
    * 此命令终止USER，如果没有数据传输，服务器关闭控制连接
    * 如果有数据传输，在 得到传输响应后服务器关闭控制连接
    * 如果用户进程正在向不同的USER传输数据，不希望对每个USER关闭然后再打开，可以使用REIN
    * 对控制连接的意外关闭，可以导致服务器运行中止(ABOR)和退出登录(QUIT)。
    */
   else if (!strcmp(command, "QUIT")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-4");
#endif

      disconnectClient();
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
   else if (!strcmp(command, "MODE")) {

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
   else if (!strcmp(command, "PASV")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-6");
#endif

      if (data.connected()) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-6-1");
#endif

         data.stop();
      }
      //dataServer.begin();
      //dataIp = Ethernet.localIP();
      dataIp   = WiFi.localIP();
      dataPort = FTP_DATA_PORT_PASV;
//data.connect( dataIp, dataPort );
//data = dataServer.available();

#ifdef FTP_DEBUG
      Serial.println("Connection management set to passive");
      Serial.println("Data port set to " + String(dataPort));
#endif

      client.println("227 Entering Passive Mode (" + String(dataIp[0]) + "," + String(dataIp[1]) + "," + String(dataIp[2]) + "," + String(dataIp[3]) + "," + String(dataPort >> 8) + "," + String(dataPort & 255) + ").");
      dataPassiveConn = true;
   }

   /**
     * PORT - Data Port
     * 数据端口
     * 参数是要使用的数据连接端口，通常情况下对此不需要命令响应。如果使用此命令时，要发送32位的IP地址和16位的TCP端口号。上面的信息以8位为一组，逗号间隔十进制传输，如下例：
     * PORT h1,h2,h3,h4,p1,p2
     */
   else if (!strcmp(command, "PORT")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-7");
#endif

      if (data) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-7-1");
#endif

         data.stop();
      }
      // get IP of data client
      dataIp[0] = atoi(parameters);
      char *p   = strchr(parameters, ',');
      for (uint8_t i = 1; i < 4; i++) {
         dataIp[i] = atoi(++p);
         p         = strchr(p, ',');
      }
      // get port of data client
      dataPort = 256 * atoi(++p);
      p        = strchr(p, ',');
      dataPort += atoi(++p);
      if (p == NULL) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-7-2");
#endif

         client.println("501 Can't interpret parameters");
      }
      else {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-7-3");
#endif

         client.println("200 PORT command successful");
         dataPassiveConn = false;
      }
   }

   /**
     * STRU - File Structure
     * 文件结构
     * 参数是一个Telnet字符代码指定文件结构。下面是代码及其意义：
     * F - 文件（非记录结构），它是默认值
     * R - 记录结构
     * P - 页结构
     */
   else if (!strcmp(command, "STRU")) {

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
   else if (!strcmp(command, "TYPE")) {

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
   else if (!strcmp(command, "ABOR")) {

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
   else if (!strcmp(command, "DELE")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-11");
#endif

      char path[FTP_CWD_SIZE];
      if (strlen(parameters) == 0) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-11-1");
#endif

         client.println("501 No file name");
      }
      else if (makePath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-11-2");
#endif

         if (!SD_MMC.exists(path)) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-11-2-1");
#endif

            client.println("550 File " + String(parameters) + " not found");
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-11-2-2");
#endif

            if (SD_MMC.remove(path)) {

#ifdef FTP_DEBUG
               Serial.println("call processCommand-11-2-2-1");
#endif

               client.println("250 Deleted " + String(parameters));
            }
            else {

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
   else if (!strcmp(command, "LIST")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-12");
#endif


      if (dataConnect()) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-12-1");
#endif

         client.println("150 Accepted data connection");
         uint16_t nm  = 0;
         File     dir = SD_MMC.open(cwdName);
         if ((!dir) || (!dir.isDirectory())) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-12-1-1");
#endif

            client.println("550 Can't open directory " + String(cwdName));
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-12-1-2");
#endif

            File file = dir.openNextFile();
            while (file) {
               String fn, fs;
               fn    = file.name();
               int i = fn.lastIndexOf("/") + 1;
               fn.remove(0, i);

#ifdef FTP_DEBUG
               Serial.println("File Name = " + fn);
#endif

               fs = String(file.size());
               if (file.isDirectory()) {
                  data.println("01-01-2000    00:00AM <DIR> " + fn);
               }
               else {
                  data.println("01-01-2000    00:00AM " + fs + " " + fn);
                  //                    data.println( " " + fn );
               }
               nm++;
               file = dir.openNextFile();
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
         data.stop();
      }
   }

   /**
     * MLSD - Listing for Machine Processing (see RFC 3659)
     */
   else if (!strcmp(command, "MLSD")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-13");
#endif

      if (!dataConnect()) {

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
         uint16_t nm = 0;
         //            Dir dir= SD.openDir(cwdName);
         File dir = SD_MMC.open(cwdName);
         char dtStr[15];
         //    if(!SD.exists(cwdName))
         if ((!dir) || (!dir.isDirectory())) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-13-2-1");
#endif

            client.println("550 Can't open directory " + String(cwdName));
            // client.println( "550 Can't open directory " +String(parameters) );
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-13-2-2");
#endif

            //                while( dir.next())
            File file = dir.openNextFile();
            //                while( dir.openNextFile())
            while (file) {
               String fn, fs;
               fn      = file.name();
               int pos = fn.lastIndexOf("/");  //ищем начало файла по последнему "/"
               fn.remove(0, pos + 1);          //Удаляем все до имени файла включительно
               fs = String(file.size());
               if (file.isDirectory()) {
                  data.println(fn);
                  //                        data.println( "Type=dir;Size=" + fs + ";"+"modify=20000101000000;" +" " + fn);
                  //                        data.println( "Type=dir;modify=20000101000000; " + fn);
               }
               else {
                  data.println(fs + " " + fn);
                  //data.println( "Type=file;Size=" + fs + ";"+"modify=20000101160656;" +" " + fn);
                  //data.println( "Type=file;Size=" + fs + ";"+"modify=20000101000000;" +" " + fn);
               }
               nm++;
               file = dir.openNextFile();
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
   else if (!strcmp(command, "NLST")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-14");
#endif

      if (!dataConnect()) {

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
         //            Dir dir=SD.openDir(cwdName);
         File dir = SD_MMC.open(cwdName);
         if (!SD_MMC.exists(cwdName)) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-14-2-1");
#endif

            client.println("550 Can't open directory " + String(parameters));
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-14-2-2");
#endif

            File file = dir.openNextFile();
            //                while( dir.next())
            while (file) {
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
   else if (!strcmp(command, "NOOP")) {

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
   else if (!strcmp(command, "RETR")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-16");
#endif

      char path[FTP_CWD_SIZE];
      if (strlen(parameters) == 0) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-16-1");
#endif

         client.println("501 No file name");
      }
      else if (makePath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-16-2");
#endif

         file = SD_MMC.open(path, "r");
         if (!file) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-1");
#endif

            client.println("550 File " + String(parameters) + " not found");
         }
         else if (!file) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-2");
#endif

            client.println("450 Can't open " + String(parameters));
         }
         else if (!dataConnect()) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-3");
#endif

            client.println("425 No data connection");
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-16-2-4");
            Serial.println("Sending " + String(parameters));
#endif

            client.println("150-Connected to port " + String(dataPort));
            client.println("150 " + String(file.size()) + " bytes to download");
            millisBeginTrans = millis();
            bytesTransfered  = 0;
            transferStatus   = 1;
         }
      }
   }

   /**
     * STOR - Store
     * 保存
     * 此命令使服务器DTP接收数据连接上传送过来的数据，并将数据保存在服务器的文件中。如果文件已存在，原文件将被覆盖。如果文件不存在，则新建文件。
     */
   else if (!strcmp(command, "STOR")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-17");
#endif

      char path[FTP_CWD_SIZE];
      if (strlen(parameters) == 0) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-17-1");
#endif

         client.println("501 No file name");
      }
      else if (makePath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-17-2");
#endif

         file = SD_MMC.open(path, "w");
         if (!file) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-17-2-1");
#endif

            client.println("451 Can't open/create " + String(parameters));
         }
         else if (!dataConnect()) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-17-2-2");
#endif

            client.println("425 No data connection");
            file.close();
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-17-2-3");
            Serial.println("Receiving " + String(parameters));
#endif

            client.println("150 Connected to port " + String(dataPort));
            millisBeginTrans = millis();
            bytesTransfered  = 0;
            transferStatus   = 2;
         }
      }
   }

   /**
     * MKD - Make Directory
     * 创建目录
     * 此命令在指定路径下创建新目录。
     */
   else if (!strcmp(command, "MKD")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-18");
#endif

      char path[FTP_CWD_SIZE];
      if (haveParameter() && makePath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-18-1");
#endif

         if (SD_MMC.exists(path)) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-18-1-1");
#endif

            client.println("521 Can't create \"" + String(parameters) + ", Directory exists");
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-18-1-2");
#endif

            if (SD_MMC.mkdir(path)) {

#ifdef FTP_DEBUG
               Serial.println("call processCommand-18-1-2-1");
#endif

               client.println("257 \"" + String(parameters) + "\" created");
            }
            else {

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
   else if (!strcmp(command, "RMD")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-19");
#endif

      char path[FTP_CWD_SIZE];
      if (haveParameter() && makePath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-19-1");
#endif

         if (SD_MMC.rmdir(path)) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-19-1-1");
            Serial.println(" Deleting " + String(parameters));
#endif

            client.println("250 \"" + String(parameters) + "\" deleted");
         }
         else {

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
   else if (!strcmp(command, "RNFR")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-20");
#endif

      buf[0] = 0;
      if (strlen(parameters) == 0) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-20-1");
#endif

         client.println("501 No file name");
      }
      else if (makePath(buf)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-20-2");
#endif

         if (!SD_MMC.exists(buf)) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-20-2-1");
#endif

            client.println("550 File " + String(parameters) + " not found");
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-20-2-2");
            Serial.println("Renaming " + String(buf));
#endif

            client.println("350 RNFR accepted - file exists, ready for destination");
            rnfrCmd = true;
         }
      }
   }

   /**
     * RNTO - Rename To
     * 重命名为
     * 此命令和上面的命令共同完成对文件的重命名。
     */
   else if (!strcmp(command, "RNTO")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-21");
#endif


      char path[FTP_CWD_SIZE];
      char dir[FTP_FIL_SIZE];
      if (strlen(buf) == 0 || !rnfrCmd) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-21-1");
#endif

         client.println("503 Need RNFR before RNTO");
      }
      else if (strlen(parameters) == 0) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-21-2");
#endif

         client.println("501 No file name");
      }
      else if (makePath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-21-3");
#endif

         if (SD_MMC.exists(path)) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-21-3-1");
#endif

            client.println("553 " + String(parameters) + " already exists");
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-21-3-2");
            Serial.println("Renaming " + String(buf) + " to " + String(path));
#endif

            if (SD_MMC.rename(buf, path)) {

#ifdef FTP_DEBUG
               Serial.println("call processCommand-21-3-2-1");
#endif

               client.println("250 File successfully renamed or moved");
            }
            else {

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
   else if (!strcmp(command, "FEAT")) {

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
   else if (!strcmp(command, "MDTM")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-23");
#endif

      client.println("550 Unable to retrieve time");
   }

   /**
     * SIZE - Size of the file
     * 获取文件大小
     */
   else if (!strcmp(command, "SIZE")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-24");
#endif

      char path[FTP_CWD_SIZE];
      if (strlen(parameters) == 0) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-24-1");
#endif

         client.println("501 No file name");
      }
      else if (makePath(path)) {

#ifdef FTP_DEBUG
         Serial.println("call processCommand-24-2");
#endif

         file = SD_MMC.open(path, "r");
         if (!file) {

#ifdef FTP_DEBUG
            Serial.println("call processCommand-24-2-1");
#endif

            client.println("450 Can't open " + String(parameters));
         }
         else {

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
   else if (!strcmp(command, "SITE")) {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-25");
#endif

      client.println("500 Unknow SITE command " + String(parameters));
   }

   /**
     * Unrecognized commands ...
     * 其他未知请求类型
     */
   else {

#ifdef FTP_DEBUG
      Serial.println("call processCommand-26");
#endif

      client.println("500 Unknow command");
   }

   return true;
}

boolean FtpServer::dataConnect()
{

#ifdef FTP_DEBUG
   Serial.println("call dataConnect");
#endif


   unsigned long startTime = millis();
   //wait 5 seconds for a data connection
   if (!data.connected()) {

#ifdef FTP_DEBUG
      Serial.println("call dataConnect-1");
#endif

      while (!dataServer.hasClient() && millis() - startTime < 10000)
      //        while (!dataServer.available() && millis() - startTime < 10000)
      {
         //delay(100);
         yield();
      }
      if (dataServer.hasClient()) {

#ifdef FTP_DEBUG
         Serial.println("call dataConnect-1-1");
#endif

         //        if (dataServer.available()) {
         data.stop();
         data = dataServer.available();

#ifdef FTP_DEBUG
         Serial.println("ftpdataserver client....");
#endif

      }
   }

   return data.connected();
}

boolean FtpServer::doRetrieve()
{

#ifdef FTP_DEBUG
   Serial.println("call doRetrieve");
#endif


   if (data.connected()) {

#ifdef FTP_DEBUG
      Serial.println("call doRetrieve-1");
#endif

      int16_t nb = file.readBytes(buf, FTP_BUF_SIZE);
      if (nb > 0) {

#ifdef FTP_DEBUG
         Serial.println("call doRetrieve-1-1");
#endif

         data.write((uint8_t *)buf, nb);
         bytesTransfered += nb;
         return true;
      }
   }
   closeTransfer();
   return false;
}

boolean FtpServer::doStore()
{

#ifdef FTP_DEBUG
   Serial.println("call doStore");
#endif


   if (data.connected()) {

#ifdef FTP_DEBUG
      Serial.println("call doStore-1");
#endif

      int16_t nb = data.readBytes((uint8_t *)buf, FTP_BUF_SIZE);
      if (nb > 0) {

#ifdef FTP_DEBUG
         Serial.println("call doStore-1-1");
#endif

         // Serial.println( millis() << " " << nb << endl;
         file.write((uint8_t *)buf, nb);
         bytesTransfered += nb;
      }
      return true;
   }
   closeTransfer();
   return false;
}

void FtpServer::closeTransfer()
{

#ifdef FTP_DEBUG
   Serial.println("call closeTransfer");
#endif


   uint32_t deltaT = (int32_t)(millis() - millisBeginTrans);
   if (deltaT > 0 && bytesTransfered > 0) {

#ifdef FTP_DEBUG
      Serial.println("call closeTransfer-1");
#endif

      client.println("226-File successfully transferred");
      client.println("226 " + String(deltaT) + " ms, " + String(bytesTransfered / deltaT) + " kbytes/s");
   }
   else {

#ifdef FTP_DEBUG
      Serial.println("call closeTransfer-2");
#endif

      client.println("226 File successfully transferred");
   }

   file.close();
   data.stop();
}

void FtpServer::abortTransfer()
{

#ifdef FTP_DEBUG
   Serial.println("call abortTransfer");
#endif


   if (transferStatus > 0) {

#ifdef FTP_DEBUG
      Serial.println("call abortTransfer-1");
#endif

      file.close();
      data.stop();
      client.println("426 Transfer aborted");

#ifdef FTP_DEBUG
      Serial.println("Transfer aborted!");
#endif

   }
   transferStatus = 0;
}

// Read a char from client connected to ftp server
//
//    update cmdLine and command buffers, iCL and parameters pointers
//
//    return:
//        -2 if buffer cmdLine is full
//        -1 if line not completed
//         0 if empty line received
//        length of cmdLine (positive) if no empty line received

int8_t FtpServer::readChar()
{

#ifdef FTP_DEBUG
   Serial.println("call readChar");
#endif


   int8_t rc = -1;

   if (client.available()) {

#ifdef FTP_DEBUG
      Serial.println("call readChar-1");
#endif

      char c = client.read();
      // char c;
      // client.readBytes((uint8_t*) c, 1);

#ifdef FTP_DEBUG
      Serial.print(c);
#endif

      if (c == '\\') {

#ifdef FTP_DEBUG
         Serial.println("call readChar-1-1");
#endif

         c = '/';
      }
      if (c != '\r') {

#ifdef FTP_DEBUG
         Serial.println("call readChar-1-2");
#endif

         if (c != '\n') {

#ifdef FTP_DEBUG
            Serial.println("call readChar-1-2-1");
#endif

            if (iCL < FTP_CMD_SIZE) {

#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-1-1");
#endif

               cmdLine[iCL++] = c;
            }
            else {

#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-1-2");
#endif

               rc = -2;  //    Line too long
            }
         }
         else {

#ifdef FTP_DEBUG
            Serial.println("call readChar-1-2-2");
#endif

            cmdLine[iCL] = 0;
            command[0]   = 0;
            parameters   = NULL;
            // empty line?
            if (iCL == 0) {

#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-2-1");
#endif

               rc = 0;
            }
            else {

#ifdef FTP_DEBUG
               Serial.println("call readChar-1-2-2-2");
#endif

               rc = iCL;
               // search for space between command and parameters
               parameters = strchr(cmdLine, ' ');
               if (parameters != NULL) {

#ifdef FTP_DEBUG
                  Serial.println("call readChar-1-2-2-2-1");
#endif

                  if (parameters - cmdLine > 4) {

#ifdef FTP_DEBUG
                     Serial.println("call readChar-1-2-2-2-1-1");
#endif

                     rc = -2;  // Syntax error
                  }
                  else {

#ifdef FTP_DEBUG
                     Serial.println("call readChar-1-2-2-2-1-2");
#endif

                     strncpy(command, cmdLine, parameters - cmdLine);
                     command[parameters - cmdLine] = 0;

                     while (*(++parameters) == ' ')
                        ;
                  }
               }
               else if (strlen(cmdLine) > 4) {

#ifdef FTP_DEBUG
                  Serial.println("call readChar-1-2-2-2-2");
#endif

                  rc = -2;  // Syntax error.
               }
               else {

#ifdef FTP_DEBUG
                  Serial.println("call readChar-1-2-2-2-3");
#endif

                  strcpy(command, cmdLine);
               }
               iCL = 0;
            }
         }
      }
      if (rc > 0) {

#ifdef FTP_DEBUG
         Serial.println("call readChar-1-3");
#endif

         for (uint8_t i = 0; i < strlen(command); i++) { command[i] = toupper(command[i]); }
      }
      if (rc == -2) {

#ifdef FTP_DEBUG
         Serial.println("call readChar-1-4");
#endif

         iCL = 0;
         client.println("500 Syntax error");
      }
   }
   return rc;
}

// Make complete path/name from cwdName and parameters
//
// 3 possible cases: parameters can be absolute path, relative path or only the name
//
// parameters:
//     fullName : where to store the path/name
//
// return:
//        true, if done

boolean FtpServer::makePath(char *fullName)
{

#ifdef FTP_DEBUG
   Serial.println("call makePath");
#endif


   return makePath(fullName, parameters);
}

boolean FtpServer::makePath(char *fullName,
                            char *param)
{

#ifdef FTP_DEBUG
   Serial.println("call makePath");
#endif


   if (param == NULL) {

#ifdef FTP_DEBUG
      Serial.println("call makePath-1");
#endif

      param = parameters;
   }

   // Root or empty?
   if (strcmp(param, "/") == 0 || strlen(param) == 0) {

#ifdef FTP_DEBUG
      Serial.println("call makePath-2");
#endif

      strcpy(fullName, "/");
      return true;
   }
   // If relative path, concatenate with current dir
   if (param[0] != '/') {

#ifdef FTP_DEBUG
      Serial.println("call makePath-3");
#endif

      strcpy(fullName, cwdName);
      if (fullName[strlen(fullName) - 1] != '/') {

#ifdef FTP_DEBUG
         Serial.println("call makePath-1-1");
#endif

         strncat(fullName, "/", FTP_CWD_SIZE);
      }
      strncat(fullName, param, FTP_CWD_SIZE);
   }
   else {

#ifdef FTP_DEBUG
      Serial.println("call makePath-4");
#endif

      strcpy(fullName, param);
   }
   // If ends with '/', remove it
   uint16_t strl = strlen(fullName) - 1;
   if (fullName[strl] == '/' && strl > 1) {

#ifdef FTP_DEBUG
      Serial.println("call makePath-5");
#endif

      fullName[strl] = 0;
   }
   if (strlen(fullName) < FTP_CWD_SIZE) {

#ifdef FTP_DEBUG
      Serial.println("call makePath-6");
#endif

      return true;
   }

   client.println("500 Command line too long");
   return false;
}

// Calculate year, month, day, hour, minute and second
//     from first parameter sent by MDTM command (YYYYMMDDHHMMSS)
//
// parameters:
//     pyear, pmonth, pday, phour, pminute and psecond: pointer of
//         variables where to store data
//
// return:
//        0 if parameter is not YYYYMMDDHHMMSS
//        length of parameter + space

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

// Create string YYYYMMDDHHMMSS from date and time
//
// parameters:
//        date, time
//        tstr: where to store the string. Must be at least 15 characters long
//
// return:
//        pointer to tstr

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

bool FtpServer::haveParameter()
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

bool FtpServer::makeExistsPath(char *path, char *param)
{

#ifdef FTP_DEBUG
   Serial.println("call makeExistsPath");
#endif


   if (!makePath(path, param)) {

#ifdef FTP_DEBUG
      Serial.println("call makeExistsPath-1");
#endif

      return false;
   }
   if (SD_MMC.exists(path)) {

#ifdef FTP_DEBUG
      Serial.println("call makeExistsPath-2");
#endif

      return true;
   }
   client.println("550 " + String(path) + " not found.");

   return false;
}
