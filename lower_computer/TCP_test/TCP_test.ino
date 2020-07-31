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

// 我们要从此网页中提取的数据的类型
struct WeatherData
{
    char city[16];    //城市名称
    char weather[32]; //天气介绍（多云...）
    char temp[16];    //温度
    char udate[32];   //更新时间
};

HTTPClient http;
String json_str;
String response;
WeatherData weatherData;

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
    // if (httpCode > 0)
    // {
    //     Serial.printf("[HTTP] POST... code: %d\n", httpCode);
    //     //判断请求是否成功
    //     if (httpCode == HTTP_CODE_OK)
    //     {
    //         //读取响应内容
    //         response = http.getString();
    //         DebugPrintln("Get the data from Internet!");
    //         DebugPrintln(response);
    //         //解析响应内容
    //         if (parseUserData(response, &weatherData))
    //         {
    //             //打印响应内容
    //             printUserData(&weatherData);
    //         }
    //     }
    // }
    // else
    // {
    //     Serial.printf("[HTTP] POST... failed, error: %s\n", http.errorToString(httpCode).c_str());
    // }
    http.end();
    delay(1000); //每1s调用一次
}

void initJsonStr(String &json_str)
{
    StaticJsonDocument<1024> doc;             //声明一个JsonDocument对象,
    JsonObject = root = doc.as<JsonObject>(); //将该对象转换为一个对象节点

    JsonObject operation_obj = root.createNestedObject("operation_obj"); //添加一个对象节点
    operation_obj["original_object_str"] = "/sd/folder1";                //操作前对象(路径)
    operation_obj["operation_type_int"] = 1;                             //操作类型
    operation_obj["modified_object_str"] = "/sd/folder2";                //操作后对象(路径)

    root["max_depth"] = 5;                                         //文件路径最大深度
    JsonArray sd_root_arr = root.createNestedArray("sd_root_arr"); //添加一个数组, 表示文件目录
    /* 根目录中有三个文件 */
    sd_root_arr.add("file_1.txt");
    sd_root_arr.add("file_2.txt");
    sd_root_arr.add("file_3.txt");

    JsonArray folder1 = sd_root_arr.createNestedArray("floder1"); //添加一个一级文件夹
    /* 一级文件夹中有两个文件 */
    sd_root_arr.add("folder1_file_1.txt");
    sd_root_arr.add("folder1_file_2.txt");
    JsonArray folder1_folser1 = folder1.createNestedArray("floder1_floder1"); //添加一个二级文件夹
    sd_root_arr.add("folder1_folser1_file_1.txt");
    JsonArray floder1_floder1_floser1 = folder1.createNestedArray("floder1_floder1_floser1"); //添加一个三级文件夹

    serializeJson(doc, json_str); //序列化JSON数据（压缩形式），并从json_str输出
}

/**
 * @Desc 解析数据 Json解析
 * 数据格式如下：
 * {
 *    "results": [
 *        {
 *            "location": {
 *                "id": "WX4FBXXFKE4F",
 *                "name": "北京",
 *                "country": "CN",
 *                "path": "北京,北京,中国",
 *                "timezone": "Asia/Shanghai",
 *                "timezone_offset": "+08:00"
 *            },
 *            "now": {
 *                "text": "多云",
 *                "code": "4",
 *                "temperature": "23"
 *            },
 *            "last_update": "2017-09-13T09:51:00+08:00"
 *        }
 *    ]
 *}
 */
bool parseUserData(String content, struct WeatherData *weatherData)
{
    //    -- 根据我们需要解析的数据来计算JSON缓冲区最佳大小
    //   如果你使用StaticJsonBuffer时才需要
    //    const size_t BUFFER_SIZE = 1024;
    //   在堆栈上分配一个临时内存池
    //    StaticJsonBuffer<BUFFER_SIZE> jsonBuffer;
    //    -- 如果堆栈的内存池太大，使用 DynamicJsonBuffer jsonBuffer 代替
    DynamicJsonBuffer jsonBuffer;

    JsonObject &root = jsonBuffer.parseObject(content);

    if (!root.success())
    {
        DebugPrintln("JSON parsing failed!");
        return false;
    }

    //复制我们感兴趣的字符串
    strcpy(weatherData->city, root["results"][0]["location"]["name"]);
    strcpy(weatherData->weather, root["results"][0]["now"]["text"]);
    strcpy(weatherData->temp, root["results"][0]["now"]["temperature"]);
    strcpy(weatherData->udate, root["results"][0]["last_update"]);
    //  -- 这不是强制复制，你可以使用指针，因为他们是指向“内容”缓冲区内，所以你需要确保
    //   当你读取字符串时它仍在内存中
    return true;
}

// 打印从JSON中提取的数据
void printUserData(const struct WeatherData *weatherData)
{
    DebugPrintln("Print parsed data :");
    DebugPrint("City : ");
    DebugPrint(weatherData->city);
    DebugPrint(", \t");
    DebugPrint("Weather : ");
    DebugPrint(weatherData->weather);
    DebugPrint(",\t");
    DebugPrint("Temp : ");
    DebugPrint(weatherData->temp);
    DebugPrint(" C");
    DebugPrint(",\t");
    DebugPrint("Last Updata : ");
    DebugPrint(weatherData->udate);
    DebugPrintln("\r\n");
}
