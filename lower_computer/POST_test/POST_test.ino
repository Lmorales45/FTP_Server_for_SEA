#include <WiFi.h>
#include <ArduinoJson.h>
#include <HTTPClient.h>

//以下三个定义为调试定义
#define DebugBegin(baud_rate) Serial.begin(baud_rate)
#define DebugPrintln(message) Serial.println(message)
#define DebugPrint(message) Serial.print(message)

const char *AP_SSID = "xxx";        // XXX -- 使用时请修改为当前你的 wifi ssid
const char *AP_PSK = "xxx";         // XXX -- 使用时请修改为当前你的 wifi 密码
const char *HOST = "192.168.1.xxx"; // xxx -- 使用时请修改为当前你PC的 IP 地址
const uint16_t PORT = xxx;          // xxx -- 使用时请修改为当前你PC的 正在监听的监听端口
const char *URL = "/server";        // 目标的URL

const unsigned long BAUD_RATE = 115200;  // serial connection speed
const unsigned long HTTP_TIMEOUT = 5000; // max respone time from server



HTTPClient http;
String json_str;
String response;

void setup()
{
    // put your setup code here, to run once:
    WiFi.mode(WIFI_STA); //设置esp32 工作模式
    DebugBegin(BAUD_RATE);
    DebugPrint("Connecting to "); //写几句提示，哈哈
    DebugPrintln(AP_SSID);
    WiFi.begin(AP_SSID, AP_PSK); //连接wifi
    WiFi.setAutoConnect(true);
    while (WiFi.status() != WL_CONNECTED)
    {
        //这个函数是wifi连接状态，返回wifi链接状态
        delay(500);
        DebugPrint(".");
    }
    DebugPrintln("");
    DebugPrintln("WiFi connected");
    DebugPrintln("IP address: " + WiFi.localIP());

    //设置超时
    http.setTimeout(HTTP_TIMEOUT);
    //封装url
    http.begin(HOST, PORT, URL);
    //以下为设置一些头  其实没什么用 最重要是后端服务器支持
    http.setUserAgent("ESP32HTTPClient");   //用户代理版本
    http.setAuthorization("esp32", "test"); //用户校验信息

    initJsonStr(json_str); //生成json字符串
}

void loop()
{
    int httpCode = http.POST(json_str);
    http.end();
    delay(5000); //每1s调用一次
}