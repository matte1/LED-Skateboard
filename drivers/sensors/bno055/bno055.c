#include "bno055.h"
#include "core/systick/systick.h"

extern volatile uint8_t   I2CMasterBuffer[I2C_BUFSIZE];
extern volatile uint8_t   I2CSlaveBuffer[I2C_BUFSIZE];
extern volatile uint32_t  I2CReadLength, I2CWriteLength;


/**************************************************************************/
/*!
   @brief  Writes a byte to the device over I2C

   @param[in] reg
              The register to write data.

   @param[in] value
              The data to write.
*/
/**************************************************************************/
static void _bno055Write8 (uint8_t reg, uint8_t value)
{
  // Clear write buffers
   memset((uint8_t *)I2CMasterBuffer, 0x00, I2C_BUFSIZE);

  I2CWriteLength = 3;
  I2CReadLength = 0;
  I2CMasterBuffer[0] = BNO055_ADDRESS;             // I2C device address
  I2CMasterBuffer[1] = reg;                       // Command register
  I2CMasterBuffer[2] = value;            // Value to write
  i2cEngine();
}


/**************************************************************************/
/*!
   @brief Reads a byte from the device

   @param reg
          The register to read.

   @return I2CSlaveBuffer
           The value read from the register
*/
/**************************************************************************/
static uint8_t _bno055Read8(uint8_t reg)
{
   // Clear write buffers
   memset((uint8_t *)I2CMasterBuffer, 0x00, I2C_BUFSIZE);

   I2CWriteLength = 2;
   I2CReadLength = 1;
   I2CMasterBuffer[0] = BNO055_ADDRESS | 0x00;     // I2C device address
   I2CMasterBuffer[1] = reg;                       // Command register
   // Append address w/read bit
   I2CMasterBuffer[2] = BNO055_ADDRESS | 0x01;
   i2cEngine();

   // Shift values to create properly formed integer
   return I2CSlaveBuffer[0];
}

/**************************************************************************/
/*!
   @brief  Reads a N bytes values over I2C

   @param[in] startReg
              The register to start reading from.

   @param[in] buf
              Buffer to put values into

   @param[in] length
              The number of register to read
*/
/**************************************************************************/
void bno055ReadLength(uint8_t startReg, uint8_t buf[], uint8_t length)
{
   // Clear write buffers
   memset((uint8_t *)I2CMasterBuffer, 0x00, I2C_BUFSIZE);

   I2CWriteLength = 2;
   I2CReadLength = length;
   // I2C device address
   I2CMasterBuffer[0] = BNO055_ADDRESS | 0x00;
   // Command register
   I2CMasterBuffer[1] = startReg;
   // Append address w/read bit
   I2CMasterBuffer[2] = BNO055_ADDRESS | 0x01;
   i2cEngine();

   // Ready data from BNO055
   int ndx;
   for (ndx = 0; ndx < length; ndx++)
      buf[ndx] = I2CSlaveBuffer[ndx];
}

/**************************************************************************/
/*!
   @brief  Initializes the BNO055 Module

   NOTE: Enumerate this init process

   1) Mode   = NDOF
   2) Reset system
   3) ClKSRC = XTAL Clock
   4) Check that we have the proper device
   5)
*/
/**************************************************************************/
bool bno055Init()
{
   /* Set Mode to Config */
   _bno055Write8(BNO055_RA_OPR_MODE, BNO055_MODE_CNFG);
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   /* Reset System */
   _bno055Write8(BNO055_RA_SYS_TRGR, BNO055_SYS_RST);
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   /* Check the Device ID */
   // NOTE: This is an infinite loop. Should return false and handle error
   uint8_t deviceID;

   while ((deviceID = _bno055Read8(BNO055_RA_DEV_ID)) != BNO055_ID)
   {
      #ifdef CFG_BNO055_DEBUG
         printf("Device ID mismatch %x%s", deviceID, CFG_PRINTF_NEWLINE);
      #endif

      systickDelay(CFG_SYSTICK_100MS_DELAY);
   }

   #ifdef CFG_BNO055_DEBUG
      printf("Device ID match %X%s", deviceID, CFG_PRINTF_NEWLINE);
   #endif

   /* Set Power Mode */
   _bno055Write8(BNO055_RA_PWR_MODE, 0x00);
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   /* Set Page Number */
   _bno055Write8(BNO055_RA_PAGE_SEL, 0x00);
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   /* Set SYSTEM TRIGGER back to 0*/
   _bno055Write8(BNO055_RA_SYS_TRGR, 0x00);
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   /* Use External Clock Source */
   // _bno055Write8(BNO055_RA_SYS_TRGR, BNO055_USE_XTAL);
   // systickDelay(10);

   // Set Mode (OPR_MODE, NDOF)
   _bno055Write8(BNO055_RA_OPR_MODE, BNO055_MODE_NDOF);
   systickDelay(CFG_SYSTICK_100MS_DELAY);

   return true;
}

/**************************************************************************/
/*!
   @brief  Read raw linear acceleration and euler angles from IMU
   Requires 16 bytes. Little Endian order

   @param[in] buf
              Buffer to read 16 bytes of raw data into.
*/
/**************************************************************************/
void bno055PackageData(uint8_t buf[])
{
   uint32_t ticks = systickGetTicks();
   bno055ReadLength(BNO055_LACC_X_L, buf, 6);
   bno055ReadLength(BNO055_EUL_HEADING_L, &buf[6], 6);
   buf[15] = (ticks >> 24) & 0xFF;
   buf[14] = (ticks >> 16) & 0xFF;
   buf[13] = (ticks >> 8)  & 0xFF;
   buf[12] =  ticks & 0xFF;
}

/**************************************************************************/
/*!
   @brief  Read Euler angles from device

   @param[in] rpy
              Buffer to hold roll pitch yaw
*/
/**************************************************************************/
void bno055ReadEuler(double rpy[])
{
   uint8_t raw[6];
   int16_t data[3];

   bno055ReadLength(BNO055_EUL_HEADING_L, raw, 6);

   data[2] = (((int16_t)raw[1]) << 8) | raw[0];
   data[0] = (((int16_t)raw[3]) << 8) | raw[2];
   data[1] = (((int16_t)raw[5]) << 8) | raw[4];

   rpy[0] = (double)data[0] / 16.0;
   rpy[1] = (double)data[1] / 16.0;
   rpy[2] = (double)data[2] / 16.0;

   #ifdef CFG_BNO055_DEBUG
      printf("Roll: %d, Pitch: %d, Yaw: %d%s",
         (int)rpy[0], (int)rpy[1], (int)rpy[2], CFG_PRINTF_NEWLINE);
   #endif
}

/**************************************************************************/
/*!
   @brief  Read quaternions x, y, z, w

   @param quat
          Buffer to read quaterion values into.
*/
/**************************************************************************/
void bno055ReadQuat(double quat[])
{
   uint8_t raw[8];
   int16_t data[4];

   bno055ReadLength(BNO055_QUA_W_L, raw, 8);

   data[0] = (((int16_t)raw[1]) << 8) | raw[0];
   data[1] = (((int16_t)raw[3]) << 8) | raw[2];
   data[2] = (((int16_t)raw[5]) << 8) | raw[4];
   data[3] = (((int16_t)raw[7]) << 8) | raw[6];

   quat[0] = (double)data[0] / 16.0;
   quat[1] = (double)data[1] / 16.0;
   quat[2] = (double)data[2] / 16.0;
   quat[3] = (double)data[3] / 16.0;

   #ifdef CFG_BNO055_DEBUG
      printf("W: %d, X: %d, Y: %d Z: %d%s",
         (int)quat[0], (int)quat[1], (int)quat[2], (int)quat[3],
         CFG_PRINTF_NEWLINE);
   #endif
}

/**************************************************************************/
/*!
   @brief  Read Linear Acceleration.

   @param laccel
          Buffer to read laccel values into
*/
/**************************************************************************/
void bno055ReadLinAccel(double laccel[])
{
   uint8_t raw[6];
   int16_t data[3];

   bno055ReadLength(BNO055_LACC_X_L, raw, 6);

   data[2] = (((int16_t)raw[1]) << 8) | raw[0];
   data[0] = (((int16_t)raw[3]) << 8) | raw[2];
   data[1] = (((int16_t)raw[5]) << 8) | raw[4];

   laccel[0] = (double)data[0] / 100.0;
   laccel[1] = (double)data[1] / 100.0;
   laccel[2] = (double)data[2] / 100.0;

   #ifdef CFG_BNO055_DEBUG
      printf("X: %d, Y: %d, Z: %d\n\r",
         (int)laccel[0], (int)laccel[1], (int)laccel[2]);
   #endif
}
