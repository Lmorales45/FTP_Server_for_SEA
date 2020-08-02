#include "FS.h"
#include "SD_MMC.h"
#include <ESPmDNS.h>
#include <SD.h>
#include <SPI.h>
#include <WebServer.h>
#include <WiFi.h>
#include <WiFiClient.h>


#define DBG_OUTPUT_PORT Serial

const char *ssid     = "Tenda_2EE7C8";  //Replace youself wifi ssid
const char *password = "sgycsq1930";    //Replace youself wifi password
const char *host     = "esp32sd";
String      wifissid = "";
String      wifipwd  = "";
WebServer   server(80);

static bool hasSD = false;

File uploadFile;
//format bytes
String formatBytes(size_t bytes)
{
   if (bytes < 1024) {
      return String(bytes) + "B";
   }
   else if (bytes < (1024 * 1024)) {
      return String(bytes / 1024.0) + "KB";
   }
   else if (bytes < (1024 * 1024 * 1024)) {
      return String(bytes / 1024.0 / 1024.0) + "MB";
   }
   else {
      return String(bytes / 1024.0 / 1024.0 / 1024.0) + "GB";
   }
}

void listDir(fs::FS &fs, const char *dirname, uint8_t levels)
{
   Serial.printf("Listing directory: %s\n", dirname);
   Serial.printf(dirname);
   File root = fs.open(dirname);
   if (!root) {
      Serial.println("Failed to open directory");
      return;
   }
   if (!root.isDirectory()) {
      Serial.println("Not a directory");
      return;
   }

   File file = root.openNextFile();
   while (file) {
      if (file.isDirectory()) {
         Serial.print("  DIR : ");
         Serial.println(file.name());
         if (levels) {
            listDir(fs, file.name(), levels - 1);
         }
      }
      else {
         Serial.print("  FILE: ");
         Serial.print(file.name());
         Serial.print("  SIZE: ");
         Serial.println(file.size());
      }
      file = root.openNextFile();
   }
}

void createDir(fs::FS &fs, const char *path)
{
   Serial.printf("Creating Dir: %s\n", path);
   if (fs.mkdir(path)) {
      Serial.println("Dir created");
   }
   else {
      Serial.println("mkdir failed");
   }
}

void removeDir(fs::FS &fs, const char *path)
{
   Serial.printf("Removing Dir: %s\n", path);
   if (fs.rmdir(path)) {
      Serial.println("Dir removed");
   }
   else {
      Serial.println("rmdir failed");
   }
}

void readFile(fs::FS &fs, const char *path)
{
   Serial.printf("Reading file: %s\n", path);

   File file = fs.open(path);
   if (!file) {
      Serial.println("Failed to open file for reading");
      return;
   }

   Serial.print("Read from file: ");
   while (file.available()) {
      Serial.write(file.read());
   }
   file.close();
}

void writeFile(fs::FS &fs, const char *path, const char *message)
{
   Serial.printf("Writing file: %s\n", path);

   File file = fs.open(path, FILE_WRITE);
   if (!file) {
      Serial.println("Failed to open file for writing");
      return;
   }
   if (file.print(message)) {
      Serial.println("File written");
   }
   else {
      Serial.println("Write failed");
   }
   file.close();
}

void appendFile(fs::FS &fs, const char *path, const char *message)
{
   Serial.printf("Appending to file: %s\n", path);

   File file = fs.open(path, FILE_APPEND);
   if (!file) {
      Serial.println("Failed to open file for appending");
      return;
   }
   if (file.print(message)) {
      Serial.println("Message appended");
   }
   else {
      Serial.println("Append failed");
   }
   file.close();
}

void renameFile(fs::FS &fs, const char *path1, const char *path2)
{
   Serial.printf("Renaming file %s to %s\n", path1, path2);
   if (fs.rename(path1, path2)) {
      Serial.println("File renamed");
   }
   else {
      Serial.println("Rename failed");
   }
}

void deleteFile(fs::FS &fs, const char *path)
{
   Serial.printf("Deleting file: %s\n", path);
   if (fs.remove(path)) {
      Serial.println("File deleted");
   }
   else {
      Serial.println("Delete failed");
   }
}

void testFileIO(fs::FS &fs, const char *path)
{
   File           file = fs.open(path);
   static uint8_t buf[512];
   size_t         len   = 0;
   uint32_t       start = millis();
   uint32_t       end   = start;
   if (file) {
      len         = file.size();
      size_t flen = len;
      start       = millis();
      while (len) {
         size_t toRead = len;
         if (toRead > 512) {
            toRead = 512;
         }
         file.read(buf, toRead);
         len -= toRead;
      }
      end = millis() - start;
      Serial.printf("%u bytes read for %u ms\n", flen, end);
      file.close();
   }
   else {
      Serial.println("Failed to open file for reading");
   }


   file = fs.open(path, FILE_WRITE);
   if (!file) {
      Serial.println("Failed to open file for writing");
      return;
   }

   size_t i;
   start = millis();
   for (i = 0; i < 2048; i++) {
      file.write(buf, 512);
   }
   end = millis() - start;
   Serial.printf("%u bytes written for %u ms\n", 2048 * 512, end);
   file.close();
}


void returnOK()
{
   server.send(200, "text/plain", "");
}

void returnOK(String msg)
{
   server.send(200, "text/plain", msg + "\r\n");
}

void returnFail(String msg)
{
   server.send(500, "text/plain", msg + "\r\n");
}

bool loadFromSdCard(String path)
{
   String dataType = "text/plain";
   if (path.endsWith("/")) {
      path += "index.htm";
   }

   if (path.endsWith(".src")) {
      path = path.substring(0, path.lastIndexOf("."));
   }
   else if (path.endsWith(".htm")) {
      dataType = "text/html";
   }
   else if (path.endsWith(".css")) {
      dataType = "text/css";
   }
   else if (path.endsWith(".js")) {
      dataType = "application/javascript";
   }
   else if (path.endsWith(".png")) {
      dataType = "image/png";
   }
   else if (path.endsWith(".gif")) {
      dataType = "image/gif";
   }
   else if (path.endsWith(".jpg")) {
      dataType = "image/jpeg";
   }
   else if (path.endsWith(".ico")) {
      dataType = "image/x-icon";
   }
   else if (path.endsWith(".xml")) {
      dataType = "text/xml";
   }
   else if (path.endsWith(".pdf")) {
      dataType = "application/pdf";
   }
   else if (path.endsWith(".zip")) {
      dataType = "application/zip";
   }

   File dataFile = SD.open(path.c_str());
   if (dataFile.isDirectory()) {
      path += "/index.htm";
      dataType = "text/html";
      dataFile = SD.open(path.c_str());
   }

   if (!dataFile) {
      return false;
   }

   if (server.hasArg("download")) {
      dataType = "application/octet-stream";
   }

   if (server.streamFile(dataFile, dataType) != dataFile.size()) {
      DBG_OUTPUT_PORT.println("Sent less data than expected!");
   }

   dataFile.close();
   return true;
}
void handleWifiPage()
{
   String content = "<html><body>Congratulations! You Now Connect to The Wifi!<br>";
   content += "You Connect Wifi Name is:" + String(ssid) + "<br>";
   content += "Wifi Password is:" + String(password) + "<br>";
   content += "You input ssid is:" + wifissid + "<br>";
   content += "You input password is:" + wifipwd + "<br>";
   content += "</body></html>";
   server.send(200, "text/html", content);
}
void handleSetWifi()
{
   String msg;
   if (server.hasArg("DISCONNECT")) {
      Serial.println("Disconnection");
      String header = "HTTP/1.1 301 OK\r\nSet-Cookie: ESPSESSIONID=0\r\nLocation: /wifiinfo\r\nCache-Control: no-cache\r\n\r\n";
      server.sendContent(header);
      return;
   }
   if (server.hasArg("WIFINAME") && server.hasArg("WIFIPWD")) {
      wifissid      = server.arg("WIFINAME");
      wifipwd       = server.arg("WIFIPWD");
      String header = "HTTP/1.1 301 OK\r\nSet-Cookie: ESPSESSIONID=1\r\nLocation: /wifiinfo\r\nCache-Control: no-cache\r\n\r\n";
      server.sendContent(header);
      Serial.println("WIFI INFO:");
      Serial.println("Wifi Name:" + wifissid);
      Serial.println("Wifi Password:" + wifipwd);
      if (WiFi.isConnected()) {
         WiFi.disconnect();
      }
      WiFi.begin(wifissid.c_str(), wifipwd.c_str());
      int i = 0;
      while (WiFi.status() != WL_CONNECTED && i++ < 50) {  //wait 25 seconds
         Serial.print(".");
         delay(500);
      }
      if (i == 51) {
         DBG_OUTPUT_PORT.print("Could not connect to");
         DBG_OUTPUT_PORT.println(wifissid);
         while (1) {
            delay(500);
         }
      }
      DBG_OUTPUT_PORT.print("Connected! IP address: ");
      DBG_OUTPUT_PORT.println(WiFi.localIP());
      return;
   }
   String content = "<html><body><form method='POST'>This is a Wifi Setting Page<br>";
   content += "Wifi SSID:<input type='text' name='WIFINAME' placeholder='wifi ssid'><br>";
   content += "Wifi Password:<input type='password' name='WIFIPWD' placeholder='wifi password''><br>";
   content += "<input type='submit' name='SUBMIT' value='Submit'></form>" + msg + "<br>";
   content += "We Can Scan The Wifi List is:<br>";
   int n = WiFi.scanNetworks();
   if (n == 0)
      content += "There is no wifi can use!<br>";
   else {
      content += "<ol>";
      for (int i = 0; i < n; i++) {
         content += (String("<li>") + String(" Wifi SSID:") + String(WiFi.SSID(i)) + String(" Wifi RSSI:") + String(WiFi.RSSI(i)) + String((WiFi.encryptionType(i) == WIFI_AUTH_OPEN) ? String(" ") : String("*")) + String("</li>"));
      }
      content += "</ol>";
   }
   content += "</body></html>";
   server.send(200, "text/html", content);
}

void handleRoot()
{
   Serial.println("Enter handleRoot");
   String header;
   String content = "<html><body><H2>Hello, you successfully connected to ESP32-F!</H2><br>";
   if (server.hasHeader("User-Agent")) {
      content += "the user agent used is : " + server.header("User-Agent") + "<br><br>";
   }
   content += "You can choose this page to visit:<br>";
   content += "<a href='/wifiset' class='button'>Wifi Setup</a><br />";
   content += "<a href='/wifiinfo' class='button'>Wifi Infomation</a><br />";
   content += "<a href='/list' class='button'>File List</a><br />";
   content += "<a href='/upload' class='button'>Upload File</a><br />";
   content += "Good Luck Everyone!";
   content += "</body></html>";
   server.send(200, "text/html", content);
}

void handleUploadWeb()
{
   File   html     = SD.open("/upload/upload.html");
   String dataType = "text/html";
   server.streamFile(html, dataType);
   Serial.println("Open Upload File");
}
void handleFileUpload()
{
   bool updone = false;
   if (server.uri() != "/edit") {
      return;
   }
   String      fileName = "";
   HTTPUpload &upload   = server.upload();
   if (upload.status == UPLOAD_FILE_START) {
      if (SD.exists((char *)upload.filename.c_str())) {
         SD.remove((char *)upload.filename.c_str());
      }
      fileName = "/upload/" + upload.filename.substring(upload.filename.lastIndexOf('\\') + 1);
      Serial.println(fileName);
      uploadFile = SD.open(fileName, FILE_WRITE);
      if (uploadFile != NULL)
         Serial.println("File exsist!");
      DBG_OUTPUT_PORT.print("Upload: START, filename: ");
      DBG_OUTPUT_PORT.println(upload.filename);
   }
   else if (upload.status == UPLOAD_FILE_WRITE) {
      if (uploadFile) {
         if (uploadFile.write(upload.buf, upload.currentSize))
            Serial.println("write Done");
      }
      DBG_OUTPUT_PORT.print("Upload: WRITE, Bytes: ");
      DBG_OUTPUT_PORT.println(upload.currentSize);
   }
   else if (upload.status == UPLOAD_FILE_END) {
      uploadFile.close();
      DBG_OUTPUT_PORT.print("Upload: END, Size: ");
      DBG_OUTPUT_PORT.println(upload.totalSize);
      String message = "Upload Done!\n\n";
      message += "URI: ";
      message += server.uri();
      message += "\nMethod: ";
      message += (server.method() == HTTP_GET) ? "GET" : "POST";
      message += "\nArguments: ";
      message += server.args();
      message += "\n";
      for (uint8_t i = 0; i < server.args(); i++) {
         message += " NAME:" + server.argName(i) + "\n VALUE:" + server.arg(i) + "\n";
      }
      server.send(200, "text/plain", message);
      updone = true;
   }
   if (updone)
      if (fileName != "")
         readFile(SD, fileName.c_str());
}

void deleteRecursive(String path)
{
   File file = SD.open((char *)path.c_str());
   if (!file.isDirectory()) {
      file.close();
      SD.remove((char *)path.c_str());
      return;
   }

   file.rewindDirectory();
   while (true) {
      File entry = file.openNextFile();
      if (!entry) {
         break;
      }
      String entryPath = path + "/" + entry.name();
      if (entry.isDirectory()) {
         entry.close();
         deleteRecursive(entryPath);
      }
      else {
         entry.close();
         SD.remove((char *)entryPath.c_str());
      }
      yield();
   }

   SD.rmdir((char *)path.c_str());
   file.close();
}

void handleDelete()
{
   if (server.args() == 0) {
      return returnFail("BAD ARGS");
   }
   String path = server.arg(0);
   if (path == "/" || !SD.exists((char *)path.c_str())) {
      returnFail("BAD PATH");
      return;
   }
   deleteRecursive(path);
   returnOK();
}

void handleCreate()
{
   if (server.args() == 0) {
      return returnFail("BAD ARGS");
   }
   String path = server.arg(0);
   if (path == "/" || SD.exists((char *)path.c_str())) {
      returnFail("BAD PATH");
      return;
   }

   if (path.indexOf('.') > 0) {
      File file = SD.open((char *)path.c_str(), FILE_WRITE);
      if (file) {
         file.write(0);
         file.close();
      }
   }
   else {
      SD.mkdir((char *)path.c_str());
   }
   returnOK();
}

String listDir2Web(fs::FS &fs, const char *dirname, uint8_t levels)
{
   String message = "";
   File   root    = fs.open(dirname);
   if (!root) {
      message += "Failed to open directory <br />";
      return message;
   }
   if (!root.isDirectory()) {
      message += "Not a directory <br />";
      return message;
   }
   File file = root.openNextFile();
   while (file) {
      if (file.isDirectory()) {
         message += "  DIR : ";
         message += String(file.name()) + String("<br />");
         if (levels) {
            message += listDir2Web(fs, file.name(), levels - 1);
         }
      }
      else {
         message += String("  FILE: ");
         message += String(file.name()) + String("<br />");
         message += String("  SIZE: ");
         message += formatBytes(file.size()) + String("<br />");
      }
      file = root.openNextFile();
   }
   return message;
}
void printDirectory()
{
   String header  = "<html><body>";
   String message = header + "<h2>List the file in the SD Card:</h2>";
   message += listDir2Web(SD, "/", 5);
   server.send(200, "text/html", message);
}

void handleNotFound()
{
   if (hasSD && loadFromSdCard(server.uri())) {
      return;
   }
   String message = "SDCARD Not Detected\n\n";
   message += "URI: ";
   message += server.uri();
   message += "\nMethod: ";
   message += (server.method() == HTTP_GET) ? "GET" : "POST";
   message += "\nArguments: ";
   message += server.args();
   message += "\n";
   for (uint8_t i = 0; i < server.args(); i++) {
      message += " NAME:" + server.argName(i) + "\n VALUE:" + server.arg(i) + "\n";
   }
   server.send(404, "text/plain", message);
   DBG_OUTPUT_PORT.print(message);
}

void setup(void)
{
   DBG_OUTPUT_PORT.begin(115200);
   DBG_OUTPUT_PORT.setDebugOutput(true);
   DBG_OUTPUT_PORT.print("\n");
   WiFi.mode(WIFI_STA);
   //Soft AP Setting
   /*IPAddress softLocal(192,168,25,1);
  IPAddress softGateway(192,168,25,1);
  IPAddress softSubnet(255,255,255,0);
  WiFi.softAPConfig(softLocal,softGateway,softSubnet);
  WiFi.softAP("ESP32_5672C","adminadmin");
   Serial.println("SoftAP IPAdress:"+WiFi.softAPIP());*/
   //Station Setting
   WiFi.begin(ssid, password);
   DBG_OUTPUT_PORT.print("Connecting to ");
   DBG_OUTPUT_PORT.println(ssid);

   // Wait for connection
   uint8_t i = 0;
   while (WiFi.status() != WL_CONNECTED && i++ < 50) {  //wait 25 seconds
      Serial.print(".");
      delay(500);
   }
   if (i == 51) {
      DBG_OUTPUT_PORT.print("Could not connect to");
      DBG_OUTPUT_PORT.println(ssid);
      while (1) {
         delay(500);
      }
   }
   DBG_OUTPUT_PORT.print("Connected! IP address: ");
   DBG_OUTPUT_PORT.println(WiFi.localIP());
   //Setting sub network

   if (MDNS.begin(host)) {
      MDNS.addService("http", "tcp", 80);
      DBG_OUTPUT_PORT.println("MDNS responder started");
      DBG_OUTPUT_PORT.print("You can now connect to http://");
      DBG_OUTPUT_PORT.print(host);
      DBG_OUTPUT_PORT.println(".local");
   }


   server.on("/", handleRoot);
   server.on("/list", HTTP_GET, printDirectory);
   server.on("/edit", HTTP_DELETE, handleDelete);
   server.on("/edit", HTTP_PUT, handleCreate);
   server.on("/upload", HTTP_GET, handleUploadWeb);
   server.on("/wifiinfo", HTTP_GET, handleWifiPage);
   server.on("/wifiset", HTTP_GET, handleSetWifi);
   server.on("/wifiset", HTTP_POST, handleSetWifi);
   server.on(
      "/edit", HTTP_POST, []() {
         returnOK();
      },
      handleFileUpload);
   server.onNotFound(handleNotFound);

   server.begin();
   DBG_OUTPUT_PORT.println("HTTP server started");

   /*if (SD.begin(SS)) {
    DBG_OUTPUT_PORT.println("SD Card initialized.");
    hasSD = true;
  }**/
   //if(!SD.begin()){
   //        Serial.println("Card Mount Failed");
   //        return;
   //    }
   if (SD_MMC.begin()) {
      Serial.println("SD opened!");
      hasSD = true;
   }
   else {
      Serial.println("Card Mount Failed!");
   }
   uint8_t cardType = SD_MMC.cardType();

   if (cardType == CARD_NONE) {
      Serial.println("No SD card attached");
      return;
   }

   Serial.print("SD Card Type: ");
   if (cardType == CARD_MMC) {
      Serial.println("MMC");
   }
   else if (cardType == CARD_SD) {
      Serial.println("SDSC");
   }
   else if (cardType == CARD_SDHC) {
      Serial.println("SDHC");
   }
   else {
      Serial.println("UNKNOWN");
   }

   uint64_t cardSize = SD_MMC.cardSize() / (1024 * 1024);
   Serial.printf("SD Card Size: %lluMB\n", cardSize);

   listDir(SD_MMC, "/", 0);
   createDir(SD_MMC, "/mydir");
   createDir(SD_MMC, "/upload");
   listDir(SD_MMC, "/", 0);
   removeDir(SD_MMC, "/mydir");
   listDir(SD_MMC, "/", 2);
   writeFile(SD_MMC, "/hello.txt", "Hello ");
   appendFile(SD_MMC, "/hello.txt", "World!\n");
   readFile(SD_MMC, "/hello.txt");
   deleteFile(SD_MMC, "/foo.txt");
   renameFile(SD_MMC, "/hello.txt", "/foo.txt");
   readFile(SD_MMC, "/foo.txt");
   testFileIO(SD_MMC, "/test.txt");
   Serial.printf("Total space: %lluMB\n", SD_MMC.totalBytes() / (1024 * 1024));
   Serial.printf("Used space: %lluMB\n", SD_MMC.usedBytes() / (1024 * 1024));
}

void loop(void)
{
   server.handleClient();
}
