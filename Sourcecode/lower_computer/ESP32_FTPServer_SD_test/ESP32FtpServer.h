
/*
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
//  2017: modified by @robo8080
//  2019: modified by @fa1ke5

/*******************************************************************************
 **                                                                            **
 **                       DEFINITIONS FOR FTP SERVER                           **
 **                                                                            **
 *******************************************************************************/

// Uncomment to print debugging info to console attached to ESP32
#define FTP_DEBUG
// 运行日志, 比调试信息更重要
#define FTP_LOG

#ifndef FTP_SERVERESP_H

#define FTP_SERVERESP_H

//#include "Streaming.h"
#include <FS.h>
#include <SD_MMC.h>
#include <WiFiClient.h>

#define FTP_SERVER_VERSION "FTP-2016-01-14"

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
   bool    haveParameter();
   bool    makeExistsPath(char *path, char *param = NULL);
   void    iniVariables();
   void    clientConnected();
   void    disconnectClient();
   boolean userIdentity();
   boolean userPassword();
   boolean processCommand();
   boolean dataConnect();
   boolean doRetrieve();
   boolean doStore();
   void    closeTransfer();
   void    abortTransfer();
   boolean makePath(char *fullname);
   boolean makePath(char *fullName, char *param);
   uint8_t getDateTime(uint16_t *pyear, uint8_t *pmonth, uint8_t *pday,
                       uint8_t *phour, uint8_t *pminute, uint8_t *second);
   char *  makeDateTimeStr(char *tstr, uint16_t date, uint16_t time);
   int8_t  readChar();

   IPAddress  dataIp;  // IP address of client for data
   WiFiClient client;
   WiFiClient data;

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
      millisDelay,
      millisEndConnection,  //
      millisBeginTrans,     // store time of beginning of a transaction
      bytesTransfered;      //
   String _FTP_USER;        // begin方法设置的用户名
   String _FTP_PASS;        // begin方法设置的密码
};

#endif  // FTP_SERVERESP_H
