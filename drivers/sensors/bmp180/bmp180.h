#ifndef _BMP180_H_
#define _BMP180_H_

#include <string.h>
#include <stdlib.h>

#include "projectconfig.h"
#include "core/systick/systick.h"
#include "core/i2c/i2c.h"

#define BMP180_ADDRESS         (0xEE)

#define BMP180_RA_ID           (0xD0)

void bmp180ReadID();

#endif
