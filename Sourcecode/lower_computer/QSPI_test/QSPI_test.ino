// include the library:
#include <FS.h>
#include <SD_MMC.h>
#include <sea_esp32_qspi.h>
#include <spartan-edge-esp32-boot.h>


// initialize the spartan_edge_esp32_boot library
spartan_edge_esp32_boot esp32Cla;

// the bitstream name which we loading
#define LOADING_DEFAULT_FIEE "/overlay/default.bit"

#define LOADING_IMAGE_FIEE "/response.bin"

#define HTTP_TIMEOUT 5000

// the setup routine runs once when you press reset:
void setup()
{
   // initialization
   esp32Cla.begin();

   // XFPGA pin Initialize
   esp32Cla.xfpgaGPIOInit();

   // loading the bitstream
   esp32Cla.xlibsSstream(LOADING_DEFAULT_FIEE);

   readFile(SD_MMC, LOADING_IMAGE_FIEE);
}

// the loop routine runs over and over again forever:
void loop()
{
   Serial.println("run");
   delay(3000);
}

void readFile(fs::FS &fs, const char *path)
{
   Serial.printf("Reading file: %s\n", LOADING_IMAGE_FIEE);

   File file = fs.open(LOADING_IMAGE_FIEE);
   if (!file) {
      Serial.println("Failed to open file for reading");
   }

   uint8_t data[32];               // 将要通过QSPI进行传输的数据
   int     address = 0;            // 将要传输数据的第一个字节位于所有数据的第几个字节
   int     c       = 0;            // 储存一字节的数据
   int     ptr     = 8;            // 指向data数据的指针, 0~3字节是宽度, 4~7字节是高度
   int     size    = file.size();  // 获得文件大小

   int2Uint8(720, data, 4);       // 写入宽度
   int2Uint8(1280, data + 4, 4);  // 写入高度

   unsigned long time_begin = millis();  // 进入循环的时间
   unsigned long time_now   = millis();  // 储存现在时间
   while (true) {
      if (!file.available()) {  // 缓存区还未接收到数据
         time_now = millis();
      }
      else {  // 缓存区接收到数据

         c = file.read();  // 读取一字节数据
         Serial.print(c);
         if (c < 0xff) {  // 读到的不是终止符
            data[ptr++] = c;
         }
         if (ptr == 32) {  // 已经读取32个字节的数据
            int2Uint8(address, data + 24, 8);
            Serial.printf("\naddress: %d\n", address);
            SeaTrans.write(address, data, 32);
            address += 32;
            ptr = 0;
         }
      }
      if (c == 0xff ||                          // 收到结束符
          address >= size ||                    // 数据量异常
          time_now - time_begin > HTTP_TIMEOUT  // 等待时间过长
      ) {
         Serial.println("\nQSPI write success!");
         break;  // 跳出循环
      }
   }
   file.close();
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