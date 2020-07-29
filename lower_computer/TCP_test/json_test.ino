#include <ArduinoJson.h> //引用ArduinoJson库
// #include "ArduinoJson.h" //也可以将文件名改为ArduinoJson.h然后这样引用

void setup()
{
    Serial.begin(115200);
    Serial.println();

    StaticJsonDocument<200> doc;              //声明一个JsonDocument对象,
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

    String json_str;            //序列化后的json字符串
    serializeJson(doc, json_str); //序列化JSON数据（压缩形式），并从json_str输出
    // 以下三行输出结果同上面一行
    // char myDoc[measureJson(doc) + 1];
    // serializeJson(doc, myDoc, measureJson(doc) + 1);
    // Serial.println(myDoc);

    Serial.println(json_str);
    Serial.println();

    serializeJsonPretty(doc, Serial); //序列化JSON数据（展开形式），并从Serial输出
    // 以下三行输出结果同上面一行
    // char myDocP[measureJsonPretty(doc) + 1];
    // serializeJsonPretty(doc, myDocP, measureJsonPretty(doc) + 1);
    // Serial.println(myDocP);
}

void loop()
{
}
