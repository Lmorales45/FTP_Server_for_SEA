/*
 * Connect the SD card to the following pins:
 *
 * SD Card | ESP32
 *    D2       12
 *    D3       13
 *    CMD      15
 *    VSS      GND
 *    VDD      3.3V
 *    CLK      14
 *    VSS      GND
 *    D0       2  (add 1K pull up after flashing)
 *    D1       4
 */

#include "FS.h"
#include "SD_MMC.h"

void listDir(fs::FS &fs, const char *dirname, uint8_t levels)
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

void setup()
{
   Serial.begin(115200);
   if (!SD_MMC.begin()) {
      Serial.println("Card Mount Failed");
      return;
   }
   uint8_t cardType = SD_MMC.cardType();

   if (cardType == CARD_NONE) {
      Serial.println("No SD_MMC card attached");
      return;
   }

   Serial.print("SD_MMC Card Type: ");
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
   /**
    * SD_MMC Card Type: SDHC
    */

   uint64_t cardSize = SD_MMC.cardSize() / (1024 * 1024);
   Serial.printf("SD_MMC Card Size: %lluMB\n", cardSize);
   /**
    * SD_MMC Card Size: 3781MB
    */

   listDir(SD_MMC, "/", 0);
   /**
    * Listing directory: /
    *   DIR : /System Volume Information
    *   DIR : /overlay
    *   DIR : /sdcard
    */

   createDir(SD_MMC, "/mydir");
   /**
    * Creating Dir: /mydir
    * Dir created
    */

   listDir(SD_MMC, "/", 0);
   /**
    * Listing directory: /
    *   DIR : /mydir
    *   DIR : /System Volume Information
    *   DIR : /overlay
    *   DIR : /sdcard
    */

   removeDir(SD_MMC, "/mydir");
   /**
    * Removing Dir: /mydir
    * Dir removed
    */

   listDir(SD_MMC, "/", 2);
   /**
    * Listing directory: /
    *   DIR : /System Volume Information
    * Listing directory: /System Volume Information
    *   FILE: /System Volume Information/IndexerVolumeGuid  SIZE: 76
    *   FILE: /System Volume Information/WPSettings.dat  SIZE: 12
    *   DIR : /overlay
    * Listing directory: /overlay
    *   FILE: /overlay/a.bit  SIZE: 538948
    *   FILE: /overlay/base.bit  SIZE: 538954
    *   FILE: /overlayip_top.bit  SIZE: 538948
    *   FILE: /overlay/dac6_wrapper.bit  SIZE: 538952
    *   FILE: /overlay/download.bit  SIZE: 538952
    *   FILE: /overlay/Lab_3_2.bit  SIZE: 538947
    *   FILE: /overlay/LED_2_1.Bit  SIZE: 538947
    *   FILE: /overlay/LED_Test.bit  SIZE: 538948
    *   FILE: /overlay/mipi_cam.bit  SIZE: 538954
    *   FILE: /overlay/spi2gpio.bit  SIZE: 538948
    *   FILE: /overlay/system_wrapper.bit  SIZE: 538950
    *   FILE: /overlay/test.bit  SIZE: 538945
    *   FILE: /overlay/uart.bit  SIZE: 538944
    *   FILE: /overlay/Uart_Bus_wrapper.bit  SIZE: 538956
    *   DIR : /sdcard
    * Listing directory: /sdcard
    */

   writeFile(SD_MMC, "/hello.txt", "Hello ");
   /**
    * Writing file: /hello.txt
    * File written
    */

   appendFile(SD_MMC, "/hello.txt", "World!\n");
   /**
    * Appending to file: /hello.txt
    * Message appended
    */

   readFile(SD_MMC, "/hello.txt");
   /**
    * Reading file: /hello.txt
    * Read from file: Hello World!
    */

   deleteFile(SD_MMC, "/foo.txt");
   /**
    * Deleting file: /foo.txt
    * Delete failed
    */

   renameFile(SD_MMC, "/hello.txt", "/foo.txt");
   /**
    * Renaming file /hello.txt to /foo.txt
    * File renamed
    */

   readFile(SD_MMC, "/foo.txt");
   /**
    * Reading file: /hello.txt
    * Read from file: Hello World!
    */

   testFileIO(SD_MMC, "/test.txt");
   Serial.printf("Total space: %lluMB\n", SD_MMC.totalBytes() / (1024 * 1024));
   Serial.printf("Used space: %lluMB\n", SD_MMC.usedBytes() / (1024 * 1024));
}

void loop()
{
}

// ets Jun  8 2016 00:22:57

// rst:0x1 (POWERON_RESET),boot:0x1b (SPI_FAST_FLASH_BOOT)
// configsip: 0, SPIWP:0xee
// clk_drv:0x00,q_drv:0x00,d_drv:0x00,cs0_drv:0x00,hd_drv:0x00,wp_drv:0x00
// mode:DIO, clock div:1
// load:0x3fff0018,len:4
// load:0x3fff001c,len:1216
// ho 0 tail 12 room 4
// load:0x40078000,len:9720
// ho 0 tail 12 room 4
// load:0x40080400,len:6352
// entry 0x400806b8
// SD_MMC Card Type: SDHC
// SD_MMC Card Size: 3781MB
// Listing directory: /
//   DIR : /System Volume Information
//   DIR : /overlay
//   DIR : /sdcard
// Creating Dir: /mydir
// Dir created
// Listing directory: /
//   DIR : /mydir
//   DIR : /System Volume Information
//   DIR : /overlay
//   DIR : /sdcard
// Removing Dir: /mydir
// Dir removed
// Listing directory: /
//   DIR : /System Volume Information
// Listing directory: /System Volume Information
//   FILE: /System Volume Information/IndexerVolumeGuid  SIZE: 76
//   FILE: /System Volume Information/WPSettings.dat  SIZE: 12
//   DIR : /overlay
// Listing directory: /overlay
//   FILE: /overlay/a.bit  SIZE: 538948
//   FILE: /overlay/base.bit  SIZE: 538954
//   FILE: /overlayip_top.bit  SIZE: 538948
//   FILE: /overlay/dac6_wrapper.bit  SIZE: 538952
//   FILE: /overlay/download.bit  SIZE: 538952
//   FILE: /overlay/Lab_3_2.bit  SIZE: 538947
//   FILE: /overlay/LED_2_1.Bit  SIZE: 538947
//   FILE: /overlay/LED_Test.bit  SIZE: 538948
//   FILE: /overlay/mipi_cam.bit  SIZE: 538954
//   FILE: /overlay/spi2gpio.bit  SIZE: 538948
//   FILE: /overlay/system_wrapper.bit  SIZE: 538950
//   FILE: /overlay/test.bit  SIZE: 538945
//   FILE: /overlay/uart.bit  SIZE: 538944
//   FILE: /overlay/Uart_Bus_wrapper.bit  SIZE: 538956
//   DIR : /sdcard
// Listing directory: /sdcard
// Writing file: /hello.txt
// File written
// Appending to file: /hello.txt
// Message appended
// Reading file: /hello.txt
// Read from file: Hello World!
// Deleting file: /foo.txt
// Delete failed
// Renaming file /hello.txt to /foo.txt
// File renamed
// Reading file: /foo.txt
// Read from file: Hello World!
// Failed to open file for reading
// 1048576 bytes written for 4910 ms
// Total space: 3773MB
// Used space: 8MB