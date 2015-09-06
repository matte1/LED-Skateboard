#ifndef _TINYFS_H_
#define _TINYFS_H_

#include <string.h>
#include <stdlib.h>

#include "projectconfig.h"
#include "core/systick/systick.h"
#include "drivers/flash/w25qxx/w25qxx.h"

#define TINYFS_ID 0x45

#define BLOCKSIZE 256

#define MAX_FILES 10

#define TFS_DEADFILE 0xAA
#define TFS_ALIVEFILE 0xCC

/* Space needed to setup a block structure */
#define TFS_BLOCKSPACE 4

/* Inode base space needed */
#define TFS_INODESPACE 36


/* Your program should use a 10240 Byte disk size giving you 40 blocks total. 
 * This is a default size. You must be able to support different possible values */
#define DEFAULT_DISK_SIZE 10240 

/* This is the convential location of the root Inode */
#define DEFAULT_ROOT_ADDRESS 1

/* Use this name for a default disk file name */
#define DEFAULT_DISK_NAME “tinyFSDisk”     

/* BLOCK TYPE DEFINES */
#define BLOCK_TYPE_SUPERBLOCK 1
#define BLOCK_TYPE_INODE	   2
#define BLOCK_TYPE_EXTBLOCK   3

typedef int fileDescriptor;

/* File system object structure */
typedef struct _TINYFS_ {
	uint8_t  id;			   /* File system mount ID */
	uint32_t root_inode;		/* Address to root inode block */
   uint32_t next_block;    /* Address to root inode block */
	uint32_t num_blocks;	   /* Number of free block */
	uint32_t base_offset;	/* TinyFS start sector */
} TINYFS;

/* File object structure */
typedef struct _FIL_ {
	uint8_t  flag;		   	/* File status flags */
	uint8_t  fptr;			   /* File R/W pointer */
	uint8_t	fattrib;		   /* Attribute */
	uint16_t fboottime;		/* Last modified time */
	uint32_t fsize;			/* File size*/
   uint32_t inode_address; /* Address of Inode */
	uint32_t start_block;	/* File start block */
	uint32_t curr_block;	   /* Current block */
   char     fname[9];      /* Short file name (8.3 format) */
} FIL;

/* File function return code (FRESULT) */
typedef enum {
	TR_OK = 0,				/*  0 */
	TR_DISK_ERR = -1,		/* -1 */
	TR_EOF = -2,			/* -2 */
	TR_MSF = -3, 			/* -3 */
	TR_BADFS = -4    		/* -4 */
} TRESULT;

TRESULT tfs_mkfs(char *filename, int nBytes);
TRESULT tfs_mount(void);
TRESULT tfs_unmount(void);
fileDescriptor tfs_openFile(char *name);
TRESULT tfs_closeFile(fileDescriptor FD);
TRESULT tfs_writeFile(fileDescriptor FD, char *buffer, uint32_t size);
TRESULT tfs_write(fileDescriptor FD, char *buffer, uint8_t numBlocks);
TRESULT tfs_deleteFile(fileDescriptor FD);
TRESULT tfs_readByte(fileDescriptor FD, char *buffer);
TRESULT tfs_seek(fileDescriptor FD, int offset);

/* Higher level APIs */
TRESULT tfs_listFiles();
TRESULT tfs_printFile(fileDescriptor FD);

#endif