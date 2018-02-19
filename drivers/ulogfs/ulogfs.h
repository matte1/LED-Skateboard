#ifndef _ULOGFS_H_
#define _ULOGFS_H_

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "projectconfig.h"
#include "core/systick/systick.h"
#include "core/uart/uart.h"

/* Driver Files */
#include "drivers/flash/w25qxx/w25qxx.h"
#include "drivers/sensors/bno055/bno055.h"
#include "drivers/sensors/mtk3339/mtk3339.h"

#define BLOCKSIZE		W25Q_PAGESIZE
#define SECTORSIZE 	W25Q_SECTORSIZE

/* Inode base space needed */
#define ULOG_INODE_LEN		9

/* BLOCK TYPE DEFINES */
#define BLOCK_TYPE_INODE	0x01

typedef struct {
	uint32_t curBlock;
	uint32_t lastInode;
	uint16_t bufferIndex;
	uint8_t  buffer[BLOCKSIZE];
} ULOGFS;

/* File system object structure */
uint8_t ulogInit();
void ulogDeleteFile();
void ulogNewFile();
void ulogCloseFile();
void ulogBufferData(uint8_t *data, int length);

/* Higher level APIs */
void ulogListFiles();
void ulogPrintFileSystem();

#endif
