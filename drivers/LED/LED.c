#include "LED.h"

void ledBlinkLoop()
{
   static int seconds = 0;
   int lastSeconds;

   lastSeconds = seconds;

   while (1) {
      seconds = systickGetSecondsActive();

      if (seconds > lastSeconds) {
         gpioSetValue(CFG_LED_PORT, CFG_LED_PIN, !gpioGetValue(CFG_LED_PORT, CFG_LED_PIN));
         lastSeconds = seconds;
      }
   }
}

void ledBlink()
{
   static int seconds = 0;
   int lastSeconds;

   lastSeconds = seconds;
   seconds = systickGetSecondsActive();

   if (seconds > lastSeconds) {
      gpioSetValue(CFG_LED_PORT, CFG_LED_PIN, !gpioGetValue(CFG_LED_PORT, CFG_LED_PIN));
   }
}
