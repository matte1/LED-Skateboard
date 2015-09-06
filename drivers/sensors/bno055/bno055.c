#include "bno055.h"
#include "core/systick/systick.h"

extern volatile uint8_t   I2CMasterBuffer[I2C_BUFSIZE];
extern volatile uint8_t   I2CSlaveBuffer[I2C_BUFSIZE];
extern volatile uint32_t  I2CReadLength, I2CWriteLength;


/**************************************************************************/
/*!
    @brief  Writes an 8 bit values over I2C
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
    @brief  Reads an 8 bit values over I2C
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

   @notice Mode   = NDOF
           ClKSRC = XTAL Clock
*/
/**************************************************************************/
bool bno055Init()
{
   /* Set Mode to Config */
   _bno055Write8(BNO055_RA_OPR_MODE, BNO055_MODE_CNFG);
   systickDelay(10);

   /* Reset System */
   _bno055Write8(BNO055_RA_SYS_TRGR, BNO055_SYS_RST);
   systickDelay(10);

   /* Check the Device ID */
   uint8_t blah;
   while ((blah = _bno055Read8(BNO055_RA_DEV_ID)) != BNO055_ID) {
      printf("Device ID mismatch %x\r\n", blah);
      systickDelay(10);
   }
   printf("Device ID match %X\r\n", _bno055Read8(BNO055_RA_DEV_ID));

   /* Set Power Mode */
   _bno055Write8(BNO055_RA_PWR_MODE, 0x00);
   systickDelay(10);

   /* Set Page Number */
   _bno055Write8(BNO055_RA_PAGE_SEL, 0x00);
   systickDelay(10);

   /* Set SYSTEM TRIGGER back to 0*/
   _bno055Write8(BNO055_RA_SYS_TRGR, 0x00);
   systickDelay(10);

   /* Use External Clock Source */
   // _bno055Write8(BNO055_RA_SYS_TRGR, BNO055_USE_XTAL);
   // systickDelay(10);

   // Set Mode (OPR_MODE, NDOF)
   _bno055Write8(BNO055_RA_OPR_MODE, BNO055_MODE_NDOF);
   systickDelay(10);

   return true;
}

/**************************************************************************/
/*!
   @brief  Read Roll Pitch Yaw

   @notice
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
      printf("Roll: %d, Pitch: %d, Yaw: %d \n\r",
         (int)rpy[0], (int)rpy[1], (int)rpy[2]);
   #endif
}

/**************************************************************************/
/*!
   @brief  Read Roll Pitch Yaw

   @notice
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
      printf("W: %d, X: %d, Y: %d Z: %d\n\r",
         (int)quat[0], (int)quat[1], (int)quat[2], (int)quat[3]);
   #endif
}

/**************************************************************************/
/*!
   @brief  Read Linear Acceleration.
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

/**************************************************************************/
/*!
   @brief  Read raw linear acceleration and euler angles from IMU
   Requires 12 bytes
*/
/**************************************************************************/
void bno055PackageData(uint8_t buf[])
{
   bno055ReadLength(BNO055_LACC_X_L, buf, 6);
   bno055ReadLength(BNO055_EUL_HEADING_L, buf+6, 6);
}
