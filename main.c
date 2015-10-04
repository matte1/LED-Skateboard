/**************************************************************************/
/*!
    @file     main.c
    @author   Matt Epperson

    @section LICENSE

    Software License Agreement (BSD License)

    Copyright (c) 2011, microBuilder SARL
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
    3. Neither the name of the copyright holders nor the
    names of its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ''AS IS'' AND ANY
    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/**************************************************************************/
#include "projectconfig.h"
#include "sysinit.h"

#include "core/gpio/gpio.h"
#include "core/systick/systick.h"

#include "core/cmd/cmd.h"

#include "drivers/sensors/mtk3339/mtk3339.h"
#include "drivers/sensors/bno055/bno055.h"
#include "drivers/sensors/bmp180/bmp180.h"
#include "drivers/flash/w25qxx/w25qxx.h"
#include "drivers/ulogfs/ulogfs.h"

void serializeFloat(float data[], uint8_t buf[], uint8_t lenght)
{
   while(lenght--)
   {
      memcpy(buf, data++, sizeof(float));
      buf += sizeof(float);
   }
}

// Simple function for blinking an LED
void blinkLEDS()
{
   static uint32_t lastSecond = 0;
   uint32_t currentSecond = 0;

   // Toggle LED once per second
   currentSecond = systickGetSecondsActive();
   if (currentSecond != lastSecond)
   {
      lastSecond = currentSecond;
      gpioSetValue(CFG_LED_PORT, CFG_LED_PIN, lastSecond % 2);
   }
}

void testFlash()
{
   w25qEraseSector(0);

   int ndx;
   uint8_t buffer[256];

   for (ndx = 0; ndx < 256; ndx++)
   {
      buffer[ndx] = ndx;
      printf("%d ", buffer[ndx]);
   }

   printf("\r\n\r\n");

   uint32_t time1 = systickGetMillisecondsActive();
   w25qWritePage(buffer, 0, 256);
   uint32_t time2 = systickGetMillisecondsActive();

   printf("Delta Time: %u\r\n\n", (unsigned int)(time2 - time1));

   memset(buffer, 0x00, 256);
   w25qReadPage(buffer, 0);

   for (ndx = 0; ndx < 256; ndx++)
   {
      buffer[ndx] = ndx;
      printf("%d ", buffer[ndx]);
   }
}

void testIMU()
{
   double rpy[3];
   uint32_t startTime = systickGetMillisecondsActive();
   while (startTime + 100 > systickGetMillisecondsActive())
      bno055ReadEuler(rpy);
}

void testGPS()
{
   while (1)
   {
      mtk3339ParseNMEA();
   }
}

// Option numero 1
void backgroundTest()
{
   int ndx = 0;

   uint8_t imuBuffer[17];
   memset(imuBuffer, 0xF0, 17);
   uint32_t startTime = systickGetMillisecondsActive();

   while (startTime + 1000 > systickGetMillisecondsActive())
   {
      for (ndx = 0; ndx < 10; ndx++)
      {
         bno055PackageData(imuBuffer+1);
         ulogBufferData(imuBuffer, 17);
         systickDelay(8);
      }
   }
}

/**************************************************************************/
/*!
   Main program entry point.  After reset, normal code execution will
   begin here.
*/
/**************************************************************************/
int main(void)
{
   // Configure cpu and peripherals
   systemInit();
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   // testIMU();

   w25qEraseBlock(0);
   systickDelay(CFG_SYSTICK_100MS_DELAY);
   ulogInit();
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   ulogNewFile();
   backgroundTest();
   ulogFlushData();
   ulogNewFile();
   // ulogNewFile();
   ulogPrintFileSystem();

   //testIMU();
   //testFlash();
   //testGPS();

   return 0;
}
