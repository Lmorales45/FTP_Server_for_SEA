#include <WiFi.h>
#include <ArduinoJson.h>
#include <HTTPClient.h>
#include <base64.h>

//以下三个定义为调试定义
#define DebugBegin(baud_rate) Serial.begin(baud_rate)
#define DebugPrintln(message) Serial.println(message)
#define DebugPrint(message) Serial.print(message)

const char *AP_SSID = "xxx";        // XXX -- 使用时请修改为当前你的 wifi ssid
const char *AP_PSK = "xxx";         // XXX -- 使用时请修改为当前你的 wifi 密码
const char *HOST = "192.168.1.xxx"; // xxx -- 使用时请修改为当前你PC的 IP 地址
const uint16_t PORT = 8000;         // 8000 -- 使用时请修改为当前你PC的 正在监听的监听端口
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
    http.setUserAgent("ESP32HTTPClient");               //用户代理版本
    http.setAuthorization("esp32", "test");             //用户校验信息
    http.addHeader("Content-Type", "application/json"); //添加请求体格式

    initJsonStr(json_str);  //生成json字符串
    DebugPrintln(json_str); //打印json字符串, 内容应该如下
    // {
    //     "operation_obj": {
    //         "original_object_str": "/sd/folder1",
    //         "operation_type_int": 1,
    //         "modified_object_str": "/sd/folder4"
    //     },
    //     "sd_root_arr": [
    //         "file_1.txt",
    //         "file_1.txt",
    //         "file_1.txt",
    //         {
    //             "folser_1": [
    //                 "folder1_file_4.txt",
    //                 "folder1_file_5.txt",
    //                 {
    //                     "folser_3": [
    //                         "folder1_folser3_file_6.txt",
    //                         "folder1_folser3_file_7.txt"
    //                     ]
    //                 }
    //             ],
    //             "folser_2": []
    //         }
    //     ]
    // }
}

void loop()
{
    http.POST(json_str);
    http.end();
    delay(5000); //每1s调用一次
}

void initJsonStr(String &json_str)
{
    StaticJsonDocument<1024> doc;           //声明一个JsonDocument对象,
    JsonObject root = doc.as<JsonObject>(); //将该对象转换为一个对象节点

    JsonObject operation_obj = root.createNestedObject("operation_obj"); //添加一个对象节点
    operation_obj["original_object_str"] = "/sd/folder1";                //操作前对象(路径)
    operation_obj["operation_type_int"] = 1;                             //操作类型
    operation_obj["modified_object_str"] = "/sd/folder4";                //操作后对象(路径)

    root["max_depth"] = 5;                                         //文件路径最大深度
    JsonArray sd_root_arr = root.createNestedArray("sd_root_arr"); //添加一个数组, 表示文件目录
    /* 根目录中有三个文件 */
    sd_root_arr.add("file_1.txt");
    sd_root_arr.add("file_2.txt");
    sd_root_arr.add("file_3.txt");

    JsonObject folders_1 = sd_root_arr.createNestedObject();      //添加一个一级文件夹对象, 储存所有的一级文件夹
    JsonArray folder_1 = folders_1.createNestedArray("folser_1"); //新增一个文件夹folser_1
    JsonArray folder_2 = folders_1.createNestedArray("folser_2"); //新增一个文件夹folser_2
    /* 一级文件夹folder_1中有两个文件 */
    folder_1.add("folder1_file_4.txt");
    folder_1.add("folder1_file_5.txt");

    JsonObject folders_2 = folder_1.createNestedObject();         //folser_1中添加一个二级文件夹对象, 储存所有二级文件夹
    JsonArray folder_3 = folders_2.createNestedArray("folser_3"); //新增一个文件夹folser_3
    folder_3.add("folder1_folser3_file_6.txt");
    folder_3.add("folder1_folser3_file_7.txt");

    serializeJson(doc, json_str); //序列化JSON数据（压缩形式），并从json_str输出
}