# 项目名称: &nbsp; **FTP Server for SEA**

## 2020年新工科联盟-Xilinx暑期学校（Summer School）项目

## 项目简介

本项目基于挂载microSD闪存卡的<abbr title="Spartan Edge Accelerator Board">SEA</abbr>开发板，目标为使用ESP32实现可以为局域网提供服务的FTP服务器，同时对SD卡的文件目录结构进行实时扫描，并将扫描结果与文件操作信息发送至上位机，上位机对信息进行图形化处理，并对图片进行压缩后以比特流的形式返回至ESP32，ESP32将比特流通过<abbr title="Quad SPI">QSPI</abbr>转发给FPGA，FPGA解码后将图片信息输出至HDMI接口，通过与HDMI接口连接的显示器便可以实时监测该FTP服务器的活动。

## 项目团队名称: &nbsp; **肝×ULLONG_MAX**

## 项目团队成员

* 石博昊
* 卢禹良

## 项目开发工具

* Vivado v2018.3 (64-bit) &nbsp; \[[下载](https://china.xilinx.com/support/download/index.html/content/xilinx/zh/downloadNav/vivado-design-tools/2018-3.html)]
    - SW Build: 2405991 on Thu Dec 6 23:38:27 MST 2018 
    - IP Build: 2404404 on Fri Dec 7 01:43:56 MST 2018
* Arduino IDE V1.8.13 &nbsp; \[[下载](https://www.arduino.cc/en/Main/Software)]

## 项目测试工具

* Postman v7.29.1 &nbsp; \[[下载](https://www.postman.com/downloads/)]
* sokit v1.3.20150507 &nbsp; \[[下载](https://github.com/sinpolib/sokit)]
* FileZilla Client v3.49.1 (64-bit) &nbsp; \[[下载](https://filezilla-project.org/)]

## 项目依赖项

* [spartan-edge-esp32-boot](https://github.com/Pillar1989/spartan-edge-esp32-boot)
* [sea_esp32_qspi](https://github.com/CutClassH/sea_esp32_qspi)
* [Arduino core for the ESP32](https://github.com/espressif/arduino-esp32)
* [ArduinoJson](https://github.com/bblanchon/ArduinoJson)

## 项目系统框图

![系统框图](images/系统框图.png)

## 项目技术路线

![系统框图](images/技术路线.png)

## 板卡型号

### Spartan Edge Accelerator Board v1.0 &nbsp; \[[详情](https://wiki.seeedstudio.com/cn/Spartan-Edge-Accelerator-Board/)]

> #### FPGA 	
> 
> | 参数                               | 数值             |
> | ---------------------------------- | ---------------- |
> | FPGA芯片                           | Spartan-7 XC7S15 |
> | 逻辑单元                           | 12, 800          |
> | Slics                              | 2000             |
> | CLB触发器                          | 16, 000          |
> | 高大分散内存 (Kb)                  | 150              |
> | 模块内存/FIFO w / ECC (36 kb each) | 10               |
> | 总内存 (Kb)                        | 360              |
> | 时钟管理 (1 MMCM + 1 PLL)          | 2                |
> | DSP Slices                         | 20               |
> 
> #### 无线 	
> 
> | 参数     | 数值                   |
> | -------- | ---------------------- |
> | 无线芯片 | Espressif ESP32-D0WDQ6 |
> | WiFi     | 802.11 b/g/n 2.4GHz    |
> | 蓝牙     | Bluetooth 4.1 with BLE |
> 
> #### 外围设备 	
> 
> | 参数              | 数值                                               |
> | ----------------- | -------------------------------------------------- |
> | 视频              | Mini HDMI x1                                       |
> | 相机              | CSI/MIPI接口 x1 (兼容Raspberry Pi相机 V1 - OV5640) |
> | SD卡              | Micro SD/TF卡槽 x1                                 |
> | FPGA GPIO         | 10针头 (IO9~IO0)                                   |
> | Arduino GPIO      | 32针头(Arduino form factor)                        |
> | Grove             | Grove连接头 x2 (I2C/D2)                            |
> | LED               | Monochrome LED x2                                  |
> | RGB               | LED x2                                             |
> | 按钮              | 启动 x1                                            |
> | 重置              | x1                                                 |
> | FPGA重置          | x1                                                 |
> | 用户              | x2                                                 |
> | 开关              | 电源模式开关x1                                     |
> | 5通道DIP开关      | x1                                                 |
> | 供电              |                                                    |
> | 工作电压          | 5V                                                 |
> | 输入输出电压      | 5V                                                 |
> | 供电模式          | USB Type C 5V                                      |
> | VIN               | 8~17V                                              |
> | Arduino Micro USB | 5V                                                 |
> 
> #### 其他 	
> 
> | 参数             | 数值          |
> | ---------------- | ------------- |
> | ADC              | 8位 ADC1173   |
> | 加速度计和陀螺仪 | 6轴 LSM6DS3TR |

## 仓库目录结构 (分支 `shi` 尚未合并)

| 文件目录                                                                | 备注                  |
| ----------------------------------------------------------------------- | --------------------- |
| \|-- README.md                                                          | 项目介绍              |
| \|-- LICENSE                                                            | 开源协议              |
| \|-- doc                                                                | 项目相关文档          |
| &nbsp;&emsp; \|-- 技术路线.vsdx                                         | Visio设计文件         |
| &nbsp;&emsp; \|-- 系统框图.vsdx                                         | Vison设计文件         |
| \|-- images                                                             | 项目图片              |
| &nbsp;&emsp; \|-- 系统框图.png                                          | 系统框图              |
| &nbsp;&emsp; \|-- 技术路线.png                                          | 技术路线              |
| \|-- ExecutableFiles                                                    | 项目可执行文件        |
| \|-- Sourcecode                                                         | 项目源码              |
| &nbsp;&emsp; \|-- lower_computer                                        | 下位机                |
| &nbsp;&emsp; &nbsp;&emsp; \|-- .clang-format                            | 代码格式规范          |
| &nbsp;&emsp; &nbsp;&emsp; \|-- ESP32_FTPServer_SD_test                  | FTP服务器测试项目     |
| &nbsp;&emsp; &nbsp;&emsp; &nbsp;&emsp; \|-- ESP32_FTPServer_SD_test.ino | FTP服务器测试项目文件 |
| &nbsp;&emsp; &nbsp;&emsp; &nbsp;&emsp; \|-- ESP32FtpServer.cpp          | FTP服务器源文件       |
| &nbsp;&emsp; &nbsp;&emsp; &nbsp;&emsp; \|-- ESP32FtpServer.h            | FTP服务器头文件       |
| &nbsp;&emsp; &nbsp;&emsp; \|-- HTTP_test                                | HTTP测试项目          |
| &nbsp;&emsp; &nbsp;&emsp; &nbsp;&emsp; \|-- HTTP_test.ino               | HTTP测试项目文件      |
| &nbsp;&emsp; &nbsp;&emsp; \|-- POST_test                                | POST请求测试项目      |
| &nbsp;&emsp; &nbsp;&emsp; &nbsp;&emsp; \|-- POST_test.ino               | POST请求测试项目文件  |
| &nbsp;&emsp; &nbsp;&emsp; \|-- SDMMC_test                               | SD_MMC测试项目        |
| &nbsp;&emsp; &nbsp;&emsp; &nbsp;&emsp; \|-- SDMMC_test.ino              | SD_MMC测试项目文件    |
| &nbsp;&emsp; \|-- upper_computer                                        | 上位机 (Django项目)   |
| &nbsp;&emsp; &nbsp;&emsp; \|-- API.md                                   | API接口描述文件       |
| &nbsp;&emsp; &nbsp;&emsp; \|-- db.sqlite3                               | 项目数据库文件        |
| &nbsp;&emsp; &nbsp;&emsp; \|-- form.jsonc                               | 格式化示例文件        |
| &nbsp;&emsp; &nbsp;&emsp; \|-- manage.py                                | 项目控制文件          |
| &nbsp;&emsp; &nbsp;&emsp; \|-- requirements.txt                         | 环境依赖描述文件      |
| &nbsp;&emsp; &nbsp;&emsp; \|-- response.bit                             | 响应体示例文件        |
| &nbsp;&emsp; &nbsp;&emsp; \|-- .idea                                    | PyCharm工程配置       |
| &nbsp;&emsp; &nbsp;&emsp; \|-- server                                   | Django 图片渲染App    |
| &nbsp;&emsp; &nbsp;&emsp; \|-- upper_computer                           | Django 项目管理App    |


## 作品照片

### 屏幕显示

![屏幕显示](Sourcecode/upper_computer/temp.jpg)