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

#include "drivers/sensors/bno055/bno055.h"
#include "drivers/flash/w25qxx/w25qxx.h"
#include "drivers/ulogfs/ulogfs.h"

void testIMU()
{
   double rpy[3];
   while (1) bno055ReadEuler(rpy);
}

// Option numero 1
void backgroundTest(uint32_t runtime)
{
   int ndx = 0;

   uint8_t imuBuffer[17];
   memset(imuBuffer, 0xF0, 17);

   for (ndx = 0; ndx < runtime; ndx++)
   {
      bno055PackageData(&imuBuffer[1]);
      ulogBufferData(imuBuffer, 17);
      systickDelay(1);
   }
}

void testUlogfs()
{
   int ndx;
   uint8_t buffer[256];
   w25qEraseBlock(0);
   ulogInit();

   // 5120 Bytes
   ulogNewFile();
   memset(buffer, 'A', 123);
   for (ndx = 0; ndx < 40; ndx++)
      ulogBufferData(buffer, 123);
   ulogCloseFile();

   ulogInit();
   // 5120 Bytes
   ulogNewFile();
   memset(buffer, 'B', 256);
   for (ndx = 0; ndx < 20; ndx++)
      ulogBufferData(buffer, 256);
   ulogCloseFile();

   // 1792 bytes
   ulogNewFile();
   memset(buffer, 'C', 17);
   for (ndx = 0; ndx < 100; ndx++)
      ulogBufferData(buffer, 17);
   ulogCloseFile();

   ulogListFiles();
   ulogPrintFileSystem();
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

   printf("HI Matt\n");

   // testUlogfs();

   // while (1) {
   //    ledBlink();
   // }

   // w25qEraseBlock(0);

   testIMU();

   // ulogInit();
   // ulogNewFile();
   // backgroundTest(500);
   // ulogCloseFile();

   // ulogNewFile();
   // backgroundTest(100);
   // ulogCloseFile();
   //
   // ulogNewFile();
   // backgroundTest(10);
   // ulogCloseFile();

   // ulogPrintFileSystem();

   // testIMU();
   //testFlash();
   //testGPS();

   return 0;
}
