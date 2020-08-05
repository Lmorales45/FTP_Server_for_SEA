#include <ArduinoJson.h>
#include <HTTPClient.h>
#include <SD_MMC.h>
#include <WiFi.h>
#include <sea_esp32_qspi.h>

#define BASE_DEBUG
#define DEPTH_DEBUG

const char *   AP_SSID = "xxx";                  // XXX -- 使用时请修改为当前你的 wifi ssid
const char *   AP_PSK  = "xxx";                  // XXX -- 使用时请修改为当前你的 wifi 密码
const char *   HOST    = "192.168.1.150";        // xxx -- 使用时请修改为当前你PC的 IP 地址
const uint16_t PORT    = 8000;                   // xxx -- 使用时请修改为当前你PC的 正在监听的监听端口
const char *   URL     = "/api/server/v1/test";  // 目标的URL
const char *   keys[]  = {"width", "height"};    // 需要收集的响应头的信息


const unsigned long BAUD_RATE    = 115200;  // serial connection speed
const unsigned long HTTP_TIMEOUT = 5000;    // max respone time from server
const unsigned long JSON_SIZE    = 65536;   // size of json document

HTTPClient upper_computer;
String     json_str;

void listDir(fs::FS &fs, JsonArray &dir, const char *dirname, uint8_t levels = 0);
void listDir(fs::FS &fs, const char *dirname, uint8_t levels = 0);
void listDir(fs::FS &fs, String &json_str, const char *dirname, uint8_t levels = 0);
bool int2Uint8(int x, uint8_t *p, int length = 4);
void updateJsonStr(String &json_str);
// void updateJsonStrByDoc(String &json_str);



void setup()
{
   // put your setup code here, to run once:
   WiFi.mode(WIFI_STA);  //设置esp32 工作模式
#ifdef BASE_DEBUG
   Serial.begin(BAUD_RATE);
   Serial.print("Connecting to ");  //写几句提示，哈哈
   Serial.println(AP_SSID);
#endif
   WiFi.begin(AP_SSID, AP_PSK);  //连接wifi
   WiFi.setAutoConnect(true);
   while (WiFi.status() != WL_CONNECTED) {
      //这个函数是wifi连接状态，返回wifi链接状态
      delay(500);
      Serial.print(".");
   }
#ifdef BASE_DEBUG
   Serial.println("");
   Serial.println("WiFi connected");
   Serial.print("IP address: ");
   Serial.println(WiFi.localIP());
#endif

   //    if (!SD_MMC.begin()) {
   // #ifdef BASE_DEBUG
   //       Serial.println("Card Mount Failed");
   // #endif
   //       return;
   //    }
   //    uint8_t cardType = SD_MMC.cardType();

   //    if (cardType == CARD_NONE) {
   // #ifdef BASE_DEBUG
   //       Serial.println("No SD_MMC card attached");
   // #endif
   //       return;
   //    }

   // #ifdef BASE_DEBUG
   //    Serial.print("SD_MMC Card Type: ");
   //    if (cardType == CARD_MMC) {
   //       Serial.println("MMC");
   //    }
   //    else if (cardType == CARD_SD) {
   //       Serial.println("SDSC");
   //    }
   //    else if (cardType == CARD_SDHC) {
   //       Serial.println("SDHC");
   //    }
   //    else {
   //       Serial.println("UNKNOWN");
   //    }
   //    uint64_t cardSize = SD_MMC.cardSize() / (1024 * 1024);
   //    Serial.printf("SD_MMC Card Size: %lluMB\n", cardSize);
   // #endif

   //设置超时
   upper_computer.setTimeout(HTTP_TIMEOUT);
   //封装url
   upper_computer.begin(HOST, PORT, URL);
   //以下为设置一些头  其实没什么用 最重要是后端服务器支持
   upper_computer.setUserAgent("ESP32HTTPClient");    //用户代理版本
   upper_computer.setAuthorization("esp32", "test");  //用户校验信息
   // 设置需要收集的响应头
   upper_computer.collectHeaders(keys, 2);

   SeaTrans.begin();  // QSPI初始化
}

void loop()
{
   // updateJsonStr(json_str);  //生成json字符串
   json_str     = "{\"client\":{\"ip\":\"192.168.1.100\"},\"operation\":{\"original_path\":\"/root/folder4\",\"type\":32,\"modified_path\":\"/root/folder1\"},\"root\":[\"file_1.txt\",\"file_1.txt\",\"file_1.txt\",{\"folser_1\":[\"folder1_file_4.txt\",\"folder1_file_5.txt\",{\"folser_3\":[\"folder1_folser3_file_6.txt\",\"folder1_folser3_file_7.txt\"]}],\"folser_2\":[]}]}";
   int httpCode = upper_computer.POST(json_str);
   if (httpCode > 0) {
#ifdef BASE_DEBUG
      Serial.printf("[HTTP] POST... code: %d\n", httpCode);
#endif
      //判断请求是否成功
      if (httpCode == HTTP_CODE_OK) {
         //读取响应内容
         // upper_computer.handleHeaderResponse();                         // 处理响应头数据
         int        width    = upper_computer.header(keys[0]).toInt();  // 获取响应头中画面宽度
         int        height   = upper_computer.header(keys[1]).toInt();  // 获取响应头中画面高度
         int        size     = upper_computer.getSize();                // 获取响应头中响应体的字节数
         WiFiClient response = upper_computer.getStream();              // 获取响应体中数据流

         uint8_t data[32];     // 将要通过QSPI进行传输的数据
         int     address = 0;  // 将要传输数据的第一个字节位于所有数据的第几个字节
         int     c       = 0;  // 储存一字节的数据
         int     ptr     = 8;  // 指向data数据的指针, 0~3字节是宽度, 4~7字节是高度

         int2Uint8(width, data, 4);       // 写入宽度
         int2Uint8(height, data + 4, 4);  // 写入高度

         unsigned long time_begin = millis();  // 进入循环的时间
         unsigned long time_now   = millis();  // 储存现在时间
         while (true) {
            if (response.available() <= 0) {  // 缓存区还未接收到数据
               time_now = millis();
            }
            else {  // 缓存区接收到数据

               c = response.read();  // 读取一字节数据
#ifdef DEPTH_DEBUG
               Serial.print(c);
#endif
               if (c < 0xff) {  // 读到的不是终止符
                  data[ptr++] = c;
               }
               if (ptr == 32) {  // 已经读取32个字节的数据
                  int2Uint8(address, data + 24, 8);
#ifdef DEPTH_DEBUG
                  Serial.printf("address: %d\n", address);
#endif
                  SeaTrans.write(address, data, 32);
                  address += 32;
                  ptr = 0;
               }
            }
            if (c == 0xff ||                          // 收到结束符
                address >= size ||                    // 数据量异常
                time_now - time_begin > HTTP_TIMEOUT  // 等待时间过长
            ) {
#ifdef DEPTH_DEBUG
               Serial.println("\nHTTP response success!");
#endif
               break;  // 跳出循环
            }
         }
      }
   }
   else {
#ifdef BASE_DEBUG
      Serial.printf("[HTTP] POST... failed, error: %s\n", upper_computer.errorToString(httpCode).c_str());
#endif
   }
}

void updateJsonStr(String &json_str)
{
   json_str = "{";
   json_str += "\"root\":[";

   listDir(SD_MMC, json_str, "/", 0);

   json_str += "]";
   json_str += "}";
}

// void updateJsonStr(String &json_str)
// {
//    json_str = "{";
//    json_str += "\"root\":[";

//    json_str += listDir(SD_MMC, "/", 5);

//    json_str += "]";
//    json_str += "}";
// }

// void updateJsonStrByDoc(String &json_str)
// {
//    DynamicJsonDocument doc(JSON_SIZE);              //声明一个JsonDocument对象
//    JsonObject          obj = doc.as<JsonObject>();  //将该对象转换为一个对象节点

//    JsonArray root = obj.createNestedArray("/root");  //添加一个数组, 表示文件目录

//    listDir(SD_MMC, root, "/", 5);

//    serializeJson(doc, json_str);  //序列化JSON数据（压缩形式），并从json_str输出
//    doc.clear();
// }


void listDir(fs::FS &fs, String &json_str, const char *dirname, uint8_t levels)
{
#ifdef DEPTH_DEBUG
   Serial.printf("Listing directory: %s\n", dirname);
#endif
   File root = fs.open(dirname);
   if (!root) {
#ifdef DEPTH_DEBUG
      Serial.println("Failed to open directory");
#endif
      return;
   }
   if (!root.isDirectory()) {
#ifdef DEPTH_DEBUG
      Serial.println("Not a directory");
#endif
      return;
   }
   String folders = "{";
   for (File file = root.openNextFile(); file; file = root.openNextFile()) {
      String path = file.name();
      String name = path.substring(path.lastIndexOf("/") + 1);
      if (file.isDirectory()) {
#ifdef DEPTH_DEBUG
         Serial.print("  DIR : ");
         Serial.println(file.name());
#endif
         folders += "\"" + name + "\":[";
         if (levels > 0) {
            listDir(fs, folders, file.name(), levels - 1);  // 递归调用
         }
         folders += "],";
      }
      else {
#ifdef DEPTH_DEBUG
         Serial.print("  FILE: ");
         Serial.print(file.name());
         Serial.print("  SIZE: ");
         Serial.println(file.size());
#endif
         json_str += "\"" + name + "\",";
      }
   }

   if (folders.endsWith(",")) {
      folders.setCharAt(folders.lastIndexOf(","), '}');  // 用 '}' 替换多余的 ','
   }
   else {
      folders += "}";
   }
   json_str += folders;
}

String listDir(fs::FS &fs, const char *dirname, uint8_t levels)
{
   String json_str = "";
#ifdef DEPTH_DEBUG
   Serial.printf("Listing directory: %s\n", dirname);
#endif
   File root = fs.open(dirname);
   if (!root) {
#ifdef DEPTH_DEBUG
      Serial.println("Failed to open directory");
#endif
      return json_str;
   }
   if (!root.isDirectory()) {
#ifdef DEPTH_DEBUG
      Serial.println("Not a directory");
#endif
      return json_str;
   }
   String folders = "{";
   for (File file = root.openNextFile(); file; file = root.openNextFile()) {
      String path = file.name();
      String name = path.substring(path.lastIndexOf("/") + 1);
      if (file.isDirectory()) {
#ifdef DEPTH_DEBUG
         Serial.print("  DIR : ");
         Serial.println(file.name());
#endif
         folders += "\"" + name + "\":[";
         if (levels > 0) {
            folders += listDir(fs, file.name(), levels - 1);  // 递归调用
         }
         folders += "],";
      }
      else {
#ifdef DEPTH_DEBUG
         Serial.print("  FILE: ");
         Serial.print(file.name());
         Serial.print("  SIZE: ");
         Serial.println(file.size());
#endif
         json_str += "\"" + name + "\",";
      }
   }

   if (folders.endsWith(",")) {
      folders.setCharAt(folders.lastIndexOf(","), '}');  // 用 '}' 替换多余的 ','
   }
   else {
      folders += "}";
   }
   json_str += folders;
   return json_str;
}

void listDir(fs::FS &fs, JsonArray &dir, const char *dirname, uint8_t levels)
{
#ifdef DEPTH_DEBUG
   Serial.printf("Listing directory: %s\n", dirname);
#endif
   File root = fs.open(dirname);
   if (!root) {
#ifdef DEPTH_DEBUG
      Serial.println("Failed to open directory");
#endif
      return;
   }
   if (!root.isDirectory()) {
#ifdef DEPTH_DEBUG
      Serial.println("Not a directory");
#endif
      return;
   }

   JsonObject folders = dir.createNestedObject();  // 该对象存放所有次级目录

   for (File file = root.openNextFile(); file; file = root.openNextFile()) {
      if (file.isDirectory()) {
#ifdef DEPTH_DEBUG
         Serial.print("  DIR : ");
         Serial.println(file.name());
#endif

         JsonArray folder = folders.createNestedArray(file.name());

         if (levels > 0) {
            listDir(fs, folder, file.name(), levels - 1);
         }
      }
      else {
#ifdef DEPTH_DEBUG
         Serial.print("  FILE: ");
         Serial.print(file.name());
         Serial.print("  SIZE: ");
         Serial.println(file.size());
#endif

         dir.add(file.size());
      }
   }
}

bool int2Uint8(int x, uint8_t *p, int length)
{
   const int mask = 0xff;
   if (length == 4 || length == 8) {
      while (length--) {
         p[length] = x & mask;
         x >>= 8;
      }
      return true;
   }
   else {
      return false;
   }
}