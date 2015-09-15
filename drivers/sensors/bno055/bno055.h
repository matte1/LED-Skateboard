#ifndef _BNO055_H_
#define _BNO055_H_

#include "projectconfig.h"
#include <string.h>
#include "core/i2c/i2c.h"


#define BNO055_ADDRESS 			0x50 // 28 <- unshifted

/* Config Addresses */
#define BNO055_RA_DEV_ID    	0x00
#define BNO055_RA_OPR_MODE  	0x3D
#define BNO055_RA_PWR_MODE  	0x3E
#define BNO055_RA_SYS_TRGR  	0x3F
#define BNO055_RA_UNIT_SEL  	0X3B
#define BNO055_RA_PAGE_SEL  	0X07

/* Euler Addresses */
#define BNO055_EUL_HEADING_L  0x1A
#define BNO055_EUL_HEADING_H  0x1B
#define BNO055_EUL_ROLL_L   	0x1C
#define BNO055_EUL_ROLL_H   	0x1D
#define BNO055_EUL_PITCH_L  	0x1E
#define BNO055_EUL_PITCH_H  	0x1F

/* Quaternion Addresses */
#define BNO055_QUA_W_L      	0x20
#define BNO055_QUA_W_H      	0x21
#define BNO055_QUA_X_L      	0x22
#define BNO055_QUA_X_H      	0x23
#define BNO055_QUA_Y_L      	0x24
#define BNO055_QUA_Y_H      	0x25
#define BNO055_QUA_Z_L      	0x26
#define BNO055_QUA_Z_H      	0x27

/* Linear Accelerometer Addresses */
#define BNO055_LACC_Z_H			0x2D
#define BNO055_LACC_Z_L			0x2C
#define BNO055_LACC_Y_H			0x2B
#define BNO055_LACC_Y_L			0x2A
#define BNO055_LACC_X_H			0x29
#define BNO055_LACC_X_L			0x28

/* Register Value Defines */
#define BNO055_ID           	0xA0
#define BNO055_MODE_NDOF    	0x0C    	// Settling time ~ 25ms
#define BNO055_MODE_CNFG    	0x00    	// Settling time ~ 25ms
#define BNO055_USE_XTAL     	0x80    	// Settling time ~ 25ms
#define BNO055_SYS_RST	    	0x02    	// Settling time ~ 25ms
#define BNO055_USE_XTAL     	0x80   	 	// Settling time ~ 25ms
#define BNO055_EUL_IN_RADS 	0x04    	// Settling time ~ 25ms
#define BNO055_EUL_IN_DEGREES 0x00  	// Settling time ~ 25ms

bool bno055Init();
void bno055ReadLength(uint8_t startReg, uint8_t values[], uint8_t length);
void bno055ReadEuler(double rpy[]);
void bno055ReadQuat(double quat[]);
void bno055ReadLinAccel(double laccel[]);
void bno055PackageData(uint8_t buf[]);

#endif
