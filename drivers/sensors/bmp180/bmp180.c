#include "bmp180.h"

extern volatile uint8_t   I2CMasterBuffer[I2C_BUFSIZE];
extern volatile uint8_t   I2CSlaveBuffer[I2C_BUFSIZE];
extern volatile uint32_t  I2CReadLength, I2CWriteLength;

/**************************************************************************/
/*!
    @brief  Writes an 8 bit values over I2C
*/
/**************************************************************************/
// static void _bmp180Write8 (uint8_t reg, uint8_t value)
// {
//   // Clear write buffers
//   uint32_t i;
//   for ( i = 0; i < I2C_BUFSIZE; i++ )
//   {
//     I2CMasterBuffer[i] = 0x00;
//   }
//
//   I2CWriteLength = 3;
//   I2CReadLength = 0;
//   I2CMasterBuffer[0] = bmp180_ADDRESS;             // I2C device address
//   I2CMasterBuffer[1] = reg;                       // Command register
//   I2CMasterBuffer[2] = value;            // Value to write
//   i2cEngine();
// }


/**************************************************************************/
/*!
    @brief  Reads an 8 bit values over I2C
*/
/**************************************************************************/
static uint8_t _bmp180Read8(uint8_t reg)
{
   // Clear write buffers
   uint32_t i;
   for ( i = 0; i < I2C_BUFSIZE; i++ )
   {
      I2CMasterBuffer[i] = 0x00;
   }

   I2CWriteLength = 2;
   I2CReadLength = 1;
   I2CMasterBuffer[0] = BMP180_ADDRESS | 0x00;     // I2C device address
   I2CMasterBuffer[1] = reg;                       // Command register
   // Append address w/read bit
   I2CMasterBuffer[2] = BMP180_ADDRESS | 0x01;
   i2cEngine();

   // Shift values to create properly formed integer
   return I2CSlaveBuffer[0];
}

/**************************************************************************/
/*!
@brief  Reads a N bytes values over I2C
*/
/**************************************************************************/
void bmp180ReadLength(uint8_t startReg, uint8_t values[], uint8_t length)
{
   // Clear write buffers
   uint32_t i;
   for (i = 0; i < I2C_BUFSIZE; i++ )
   {
      I2CMasterBuffer[i] = 0x00;
   }

   I2CWriteLength = 2;
   I2CReadLength = length;
   // I2C device address
   I2CMasterBuffer[0] = BMP180_ADDRESS | 0x00;
   // Command register
   I2CMasterBuffer[1] = startReg;
   // Append address w/read bit
   I2CMasterBuffer[2] = BMP180_ADDRESS | 0x01;
   i2cEngine();

   for (i =0; i < length; i++)
   {
      values[i] = I2CSlaveBuffer[i];
   }
}

/**************************************************************************/
/*!
   @brief  Initializes the bmp180 Module
*/
/**************************************************************************/
void bmp180ReadID()
{
   uint8_t ID;
   ID = _bmp180Read8(BMP180_RA_ID);
   printf("ID: %x\n", ID);
}
