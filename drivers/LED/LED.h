#ifndef _LED_H_
#define _LED_H_

#include "projectconfig.h"
#include "core/gpio/gpio.h"
#include "core/systick/systick.h"

void ledBlink();
void ledBlinkLoop();

#endif
