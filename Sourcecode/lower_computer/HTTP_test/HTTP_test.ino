#include <ArduinoJson.h>
#include <HTTPClient.h>
#include <SD_MMC.h>
#include <WiFi.h>
#include <sea_esp32_qspi.h>

#define BASE_DEBUG
#define DEPTH_DEBUG

//以下三个定义为调试定义
#define DebugBegin(baud_rate) Serial.begin(baud_rate)
#define DebugPrintln(message) Serial.println(message)
#define DebugPrint(message) Serial.print(message)

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

void listDir(fs::FS &fs, JsonArray &dir, const char *dirname, uint8_t levels);
bool int2Uint8(int x, uint8_t *p, int length = 4);
void updateJsonStr(String &json_str);


void setup()
{
   // put your setup code here, to run once:
   WiFi.mode(WIFI_STA);  //设置esp32 工作模式
#ifdef BASE_DEBUG
   DebugBegin(BAUD_RATE);
   DebugPrint("Connecting to ");  //写几句提示，哈哈
   DebugPrintln(AP_SSID);
#endif
   WiFi.begin(AP_SSID, AP_PSK);  //连接wifi
   WiFi.setAutoConnect(true);
   while (WiFi.status() != WL_CONNECTED) {
      //这个函数是wifi连接状态，返回wifi链接状态
      delay(500);
      DebugPrint(".");
   }
#ifdef BASE_DEBUG
   DebugPrintln("");
   DebugPrintln("WiFi connected");
   DebugPrintln("IP address: " + WiFi.localIP());
#endif

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
   updateJsonStr(json_str);  //生成json字符串
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

         uint8_t data[32];  // 将要通过QSPI进行传输的数据
         // 空间划分方式 |16字节数据|4字节屏幕宽度|4字节屏幕高度|8字节地址|
         int address = 0;  // 将要传输数据的第一位位于bitstream的第几位
         int c       = 0;  // 储存一字节的数据
         int ptr     = 8;  // 指向data数据的指针, 0~3字节是宽度, 4~7字节是高度

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
               if (c < 0xff) {       // 读到的不是终止符
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
                (address - 2) >= size ||              // 数据量异常
                time_now - time_begin > HTTP_TIMEOUT  // 等待时间过长
            ) {
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
   DynamicJsonDocument doc(JSON_SIZE);              //声明一个JsonDocument对象
   JsonObject          obj = doc.as<JsonObject>();  //将该对象转换为一个对象节点

   JsonArray root = obj.createNestedArray("/root");  //添加一个数组, 表示文件目录

   listDir(SD_MMC, root, "/", 5);

   serializeJson(doc, json_str);  //序列化JSON数据（压缩形式），并从json_str输出
   doc.clear();
}

void listDir(fs::FS &fs, JsonArray &dir, const char *dirname, uint8_t levels)
{
   Serial.printf("Listing directory: %s\n", dirname);

   File root = fs.open(dirname);
   if (!root) {
      Serial.println("Failed to open directory");
      return;
   }
   if (!root.isDirectory()) {
      Serial.println("Not a directory");
      return;
   }

   JsonObject folders = dir.createNestedObject();  // 该对象存放所有次级目录

   for (File file = root.openNextFile(); file; file = root.openNextFile()) {
      if (file.isDirectory()) {
         Serial.print("  DIR : ");
         Serial.println(file.name());

         JsonArray folder = folders.createNestedArray(file.name());

         if (levels > 0) {
            listDir(fs, folder, file.name(), levels - 1);
         }
      }
      else {
         Serial.print("  FILE: ");
         Serial.print(file.name());
         Serial.print("  SIZE: ");
         Serial.println(file.size());

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