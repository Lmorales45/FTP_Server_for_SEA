
/**
 * FTP SERVER FOR ESP8266
 * based on FTP Serveur for Arduino Due and Ethernet shield (W5100) or WIZ820io (W5200)
 * based on Jean-Michel Gallego's work
 * modified to work with esp8266 SPIFFS by David Paiva (david@nailbuster.com)
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
// 2017: modified by @robo8080      https://github.com/robo8080/ESP32_FTPServer_SD
// 2019: modified by @fa1ke5        https://github.com/fa1ke5/ESP32_FTPServer_SD_MMC
// 2020: modified by @Zuoqiu-Yingyi https://github.com/Zuoqiu-Yingyi/FTP_Server_for_SEA/tree/master/Sourcecode/FTPServer

/*******************************************************************************
 **                                                                            **
 **                       DEFINITIONS FOR FTP SERVER                           **
 **                                                                            **
 *******************************************************************************/


#ifndef FTP_SERVERESP_H

#define FTP_SERVERESP_H

//#include "Streaming.h"
#include <FS.h>
#include <SD_MMC.h>
#include <WiFiClient.h>

// Uncomment to print debugging info to console attached to ESP8266

// Test information (An identifier for each branch) will be printed to Serial after definition
// 定义后将在每个分支中向控制台打印唯一标识, 方便快速快速定位
#define FTP_DEBUG

// Run log will be printed to Serial after definition
// 定义后将打印运行日志
#define FTP_LOG

// Setting to true will start new features
// 设置为ture将启用FTP服务器的新特性
#define FTP_NEW_FEATURES ture

#define FTP_SERVER_VERSION "FTP-2020-08-06"

// Command port on wich server is listening
#define FTP_CTRL_PORT 21

// Data port in passive mode
#define FTP_DATA_PORT_PASV 50009

// Disconnect client after 5 minutes of inactivity
#define FTP_TIME_OUT 5

// 与上一个客户终止连接后休眠时间(单位: ms)
#define FTP_TIME_DELAY 200

// max size of a command
#define FTP_CMD_SIZE 255 + 8

// max size of a directory name
#define FTP_CWD_SIZE 255 + 8

// max size of a file name
#define FTP_FIL_SIZE 255

// size of file buffer for read/write
// #define FTP_BUF_SIZE 512       //512

// size of file buffer for read/write
// #define FTP_BUF_SIZE 2 * 1460  //512

//  700 KByte/s download in AP mode, direct connection.
#define FTP_BUF_SIZE 4096  //512

class FtpServer
{
  public:
   void begin(String uname, String pword);
   void handleFTP();

  private:
   bool    haveParameter();                                 // 判断请求中是否存在参数
   bool    makeExistsPath(char *path, char *param = NULL);  // 计算出目标路径, 并判断目标路径是否存在
   void    iniVariables();                                  // 变量初始化
   void    clientConnected();                               // 成功建立连接
   void    disconnectClient();                              // 中断连接
   boolean userIdentity();                                  // 验证用户名
   boolean userPassword();                                  // 服务器验证密码
   boolean processCommand();                                // 解析客户请求指令
   boolean dataConnect();                                   // 启动数据连接
   boolean doRetrieve();                                    // 下载文件的中的一块数据
   boolean doStore();                                       // 上传文件的中的一块数据
   void    closeTransfer();                                 // 传输活动因传输完成终止
   void    abortTransfer();                                 // 数据传输活动因意外终止
   boolean makePath(char *fullname);                        // 计算出目标路径, 默认为请求中的参数为目标
   boolean makePath(char *fullName, char *param);           // 计算出目标路径
   uint8_t getDateTime(uint16_t *pyear, uint8_t *pmonth, uint8_t *pday,
                       uint8_t *phour, uint8_t *pminute, uint8_t *second);  // 获取当前日期与时间(未使用)
   char *  makeDateTimeStr(char *tstr, uint16_t date, uint16_t time);
   int8_t  readChar();  // 从FTP连接中读取请求行的一个字符

   IPAddress  dataIp;  // IP address of client for data 数据传输连接的IP
   WiFiClient client;  // 客户连接
   WiFiClient data;    // 数据传输连接

   File file;

   boolean  dataPassiveConn;        // 服务器是否是被动状态
   uint16_t dataPort;               // 数据端口
   char     buf[FTP_BUF_SIZE];      // data buffer for transfers 传输缓冲区, 重命名时保存原名称
   char     cmdLine[FTP_CMD_SIZE];  // where to store incoming char from client 命令行信息
   char     cwdName[FTP_CWD_SIZE];  // name of current directory 当前目录名
   char     command[5];             // command sent by client
   boolean  rnfrCmd;                // previous command was RNFR 重命名需要两个命令(RNFR, RNTO), 此为成功解析RNFR的标志
   char *   parameters;             // point to begin of parameters sent by client 指向客户端发送的参数的起点
   uint16_t iCL;                    // pointer to cmdLine next incoming char 指向命令行信息末尾(下一个空)
   int8_t   cmdStatus,              // status of ftp command connexion
      transferStatus;               // status of ftp data transfer
   uint32_t millisTimeOut,          // disconnect after 5 min of inactivity
      millisDelay,                  // 延迟时的终止时间
      millisEndConnection,          // 相应请求的终止时间
      millisBeginTrans,             // store time of beginning of a transaction 文件上传开始时间
      bytesTransfered;              // 数据传输传输的字节u
   String _FTP_USER;                // begin方法设置的用户名
   String _FTP_PASS;                // begin方法设置的密码
};

#endif  // FTP_SERVERESP_H
