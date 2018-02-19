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
#include "core/adc/adc.h"
#include "core/uart/uart.h"
#include "drivers/LED/LED.h"

#include "drivers/sensors/bno055/bno055.h"


extern void ws2811_write(uint8_t *pixel_data, unsigned byte_cnt);
extern void ws2812_write(uint8_t *pixel_data, unsigned byte_cnt);

// TODO: Move this into its own file
#define PXL_CNT 78
static uint8_t LED_RED[]    = {0x00, 0x3F, 0x00};
static uint8_t LED_ORANGE[] = {0x12, 0x3F, 0x00};
static uint8_t LED_YELLOW[] = {0x24, 0x3F, 0x01};

void testIMU()
{
   double rpy[3];
   while (1) bno055ReadEuler(rpy);
}

/* Sets a string of neopixels based on yaw data. There is 90 pixels
 * lining the inside of the skateboard. Each pixel is mapped to 4 degrees of
 * rotation. To save time the yaw is shifted by 2 in order to divide by 4.
 *
 * Example: Yaw = 83, pixel_idx = 83>>2 = 20
 */
void testNeoPixel_Yaw()
{
   static uint8_t pixel_data[90 * 3];
   double rpy[3];
   int pixel_idx = 0;
   int counter = 1250;

   while (1) {
      memset(pixel_data, 0x00, 270);
      bno055ReadEuler(rpy);

      pixel_idx = (int)rpy[2] >> 2;
      printf("Pixel idx: %d\n\r", pixel_idx);
      pixel_data[pixel_idx * 3] = 0x3F;
      ws2811_write((uint8_t *)&pixel_data[0], 270);

      while (counter--) {
         __asm volatile("NOP");
      }

      pixel_data[0]++;
      counter = 1250;
   }
}


/* Sets LEDS racing down both sides of the skateboard.
 *
 * TODO: Figure out correct timing to get appx 40hz
 */
void testNeoPixel_RacingStripes()
{
   uint8_t pixels[PXL_CNT * 3];
   int counter = 1250;
   int idx;

   while (1) {

      for (idx = PXL_CNT - 3; idx > PXL_CNT/2 - 2; idx--) {
         memset(pixels, 0x00, PXL_CNT*3);


         // Left Side
         memcpy(&pixels[idx*3], LED_RED,    3);
         memcpy(&pixels[(idx+1)*3], LED_ORANGE, 3);
         memcpy(&pixels[(idx+2)*3], LED_YELLOW,    3);
         // Right Side
         memcpy(&pixels[(PXL_CNT - idx + 2) * 3], LED_RED,    9);
         memcpy(&pixels[(PXL_CNT - idx + 1) * 3], LED_ORANGE, 9);
         memcpy(&pixels[(PXL_CNT - idx) * 3],     LED_YELLOW, 9);


         ws2811_write((uint8_t *)pixels, PXL_CNT * 3);

         // TODO: Put this into ws2811_utils.s
         while (counter--) {
            __asm volatile("NOP");
         }

         pixels[0]++;
         counter = 1250;
         systickDelay(1);
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
   systemInit();

   gpioSetDir(0, 10, gpioDirection_Output);
   gpioSetValue(0, 10, 1);

   // testNeoPixel_Yaw();
   testNeoPixel_RacingStripes();
   // int counter = 1250;
   // // static uint8_t pixel_data[] = {
   // //    0x00,0x3F,0x00, // red
   // //    0x3F,0x3F,0x3F, // white
   // //    0x00,0x00,0x3F, // blue
   // //    0x3F,0x00,0x00, // green
   // //    0x00,0x3F,0x00, // red
   // //    0x3F,0x3F,0x3F, // white
   // //    0x00,0x00,0x3F, // blue
   // // };
   // uint8_t pixel_data[180];
   // int i = 0;
   //
   // memset(pixel_data, 0x00, 180);
   //
   // for (i = 0; i < 90; i++) {
   //    if (i % 3 == 0) {
   //       pixel_data[i] = 0xFF;
   //    }
   // }
   //
   // memset(pixel_data, 0x00, 3);
   //
   // while (1) {
   //    ws2811_write((uint8_t *)&pixel_data[0], 90);
   //    while (counter--) {
   //       __asm volatile("NOP");
   //    }
   //    pixel_data[0]++;
   //    counter = 3000;
   // }

   return 0;
}
