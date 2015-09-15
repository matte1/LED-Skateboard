#ifndef _ULOGFS_H_
#define _ULOGFS_H_

#include <string.h>
#include <stdlib.h>

#include "projectconfig.h"
#include "core/systick/systick.h"
#include "drivers/flash/w25qxx/w25qxx.h"

/* Sensor Driver Files */
#include "drivers/sensors/bno055/bno055.h"
#include "drivers/sensors/mtk3339/mtk3339.h"

#ifdef CFG_W25QXX
	#define BLOCKSIZE		W25Q_PAGESIZE
	#define SECTORSIZE 	W25Q_SECTORSIZE
#endif

/* Inode base space needed */
#define ULOG_INODE_LEN		9

/* BLOCK TYPE DEFINES */
#define BLOCK_TYPE_INODE	2

typedef struct {
	uint32_t nextBlock;
	uint32_t lastInode;
	uint16_t  bufferIndex;
	uint8_t  buffer[BLOCKSIZE];
} ULOGFS;

/* File system object structure */
uint8_t ulogInit();
void ulogDeleteFile();
void ulogNewFile();
void ulogBufferData(uint8_t *data, int length);
void ulogFlushData();

/* Higher level APIs */
void ulogListFiles();
void ulogPrintFileSystem();

#endif
