/**************************************************************************/
/*!
    @file     ulogfs.c
    @author   Matt Epperson

    @section Overview

    This is a very primitive file system for storing information into flash
    memory. The idea is to have files be sector aligned because the minimum
    erase size is for a sector. There can be a supernode at the beginning
    that contains pointers to all the other files.
*/
/**************************************************************************/

#include "ulogfs.h"

static ULOGFS uLogFS;

/**************************************************************************/
/*!
	@brief This assumes a that the next free block is unkown and scans from
   beginning of memory trying to find the next free sector.

   NOTE: This is defenitely broken... If we unluckily get a sector that has
   data in put starts with 0xFF then were SOL.

	@return address
         The address of the next avaliable block
*/
/**************************************************************************/
static uint32_t _ulogNextFreeBlock()
{
   uint32_t address = 0;

   while (w25qReadByte(address, 0) != 0xFF && address < CFG_W25QXX_MAX_ADDRESS)
      address += SECTORSIZE;

   return address;
}


/**************************************************************************/
/*!
	@brief This will be called during system init in order to perpare for
   logging data. It will set a few variable such as nextBlock and numBlocks

   TODO: 1) Find where the last Inode is at.
         2) Add return codes for error handling. This could just return true
         if there is room avaliable and false if not

   @return 1
*/
/**************************************************************************/
uint8_t ulogInit()
{
	uLogFS.nextBlock = _ulogNextFreeBlock();
   uLogFS.bufferIndex = 0;
   uLogFS.lastInode = 0;

   #ifdef CFG_ULOGFS_DEBUG
      printf("Init Block: %u%s", (unsigned int)uLogFS.nextBlock,
         CFG_PRINTF_NEWLINE);
   #endif

   return 1;
}

/**************************************************************************/
/*!
   @brief Writes buffer ‘buffer’ of size ‘size’, which represents PART of a file’s
   content to the file system.

   @NOTE: Need to flush data on the very last BufferData that is called

   @param[in] data
         Data to copy to the internal buffer

   @param[in] length
         Length of data to copy to the internal buffer
*/
/**************************************************************************/
void ulogBufferData(uint8_t *data, int length)
{
   int spaceLeft = BLOCKSIZE - uLogFS.bufferIndex;

   // If we have enough room to copy all the data into the buffer do so
   // Otherwise copy what we can and write it to flash
   if (spaceLeft >= length)
   {
      memcpy(&uLogFS.buffer[uLogFS.bufferIndex], data, length);
      uLogFS.bufferIndex += length;
   }
   else
   {
      memcpy(&uLogFS.buffer[uLogFS.bufferIndex], data, spaceLeft);
	   w25qWritePage(uLogFS.buffer, uLogFS.nextBlock, BLOCKSIZE);
      memcpy(uLogFS.buffer, &data[spaceLeft], length - spaceLeft);
      uLogFS.bufferIndex = length - spaceLeft;
	   uLogFS.nextBlock += BLOCKSIZE;
   }
}

/**************************************************************************/
/*!
   @brief Writes any data stored in buffer to the flash chip and resets
   the index back to 0.
*/
/**************************************************************************/
void ulogFlushData()
{
   if (uLogFS.bufferIndex > 0)
   {
   	w25qWritePage(uLogFS.buffer, uLogFS.nextBlock, uLogFS.bufferIndex);
      uLogFS.nextBlock += BLOCKSIZE;
      uLogFS.bufferIndex = 0;
   }
}

/**************************************************************************/
/*!
	@brief Creates a new file by writting a new Inode. There is a lot of unused
   space inside these Inodes that should be used to track file stats. Number
   of sectors used, time ended, last Inode for faster file searching.
*/
/**************************************************************************/
void ulogNewFile()
{
	uint8_t buf[ULOG_INODE_LEN];
   uint32_t systime;

   systime = systickGetSecondsActive();

   buf[0] = BLOCK_TYPE_INODE;

   // Write Start Time
	buf[1] = (systime >> 24) & 0xFF;
   buf[2] = (systime >> 16) & 0xFF;
   buf[3] = (systime >> 8) & 0xFF;
   buf[4] =  systime & 0xFF;

   // Make sure we are sector aligned
   if (uLogFS.nextBlock % SECTORSIZE != 0)
      uLogFS.nextBlock = ((int)(uLogFS.nextBlock / SECTORSIZE) + 1) * SECTORSIZE;

   w25qWritePage(buf, uLogFS.nextBlock, 5);

	buf[5] = (uLogFS.nextBlock >> 24) & 0xFF;
   buf[6] = (uLogFS.nextBlock >> 16) & 0xFF;
   buf[7] = (uLogFS.nextBlock >> 8) & 0xFF;
   buf[8] =  uLogFS.nextBlock & 0xFF;

   // TODO: Add GPS Time, Date if possible
   // if (gps_available)
   // {
   //    buf[9] =
   //    buf[10] =
   //    buf[11] =
   //    buf[12] =
   //    buf[13] =
   //    buf[14] =
   //    buf[15] =
   //    buf[16] =
   // }

   // Write this inodes address back to the lastInode's pointer to this file
   if (uLogFS.nextBlock != 0)
      w25qWritePage(buf, uLogFS.lastInode, ULOG_INODE_LEN);

   // Update where the last Inode was
   uLogFS.lastInode = uLogFS.nextBlock;
   // Update nextBlock
   uLogFS.nextBlock += BLOCKSIZE;
}


/**************************************************************************/
/*!
   @brief Goes through file system and prints out all files and the
          time that they were created.
*/
/**************************************************************************/
void ulogListFiles()
{
   uint32_t fileTime, address = 0;
	uint8_t buf[BLOCKSIZE];

   w25qReadPage(buf, address);

   while (buf[0] != 0xFF && address < CFG_W25QXX_MAX_ADDRESS)
	{
		if (buf[0] == BLOCK_TYPE_INODE)
		{
			fileTime = (buf[1] << 24) |
						  (buf[2] << 16) |
						  (buf[3] << 8)  |
						   buf[4];

         printf("Found File at Time %u at %u%s", (unsigned int)fileTime,
				(unsigned int)address, CFG_PRINTF_NEWLINE);

			address = (buf[5] << 24) |
						 (buf[6] << 16) |
						 (buf[7] << 8)  |
						  buf[8];
		}
      else
      {
         printf("No File at %u%s", (unsigned int)address, CFG_PRINTF_NEWLINE);
         return;
      }
      w25qReadPage(buf, address);
	}

}

/**************************************************************************/
/*!
   @brief Prints out all blocks of data starting at the fist byte.

   TODO: Test this by writing chars out to file. This will create a more compact
   binary file thats easier to manipulate.

   TODO: Fix issue where a good page that unluckily starts with 0xFF stops
   progress.
*/
/**************************************************************************/
void ulogPrintFileSystem()
{
   int ndx;
   uint32_t address = 0;
	uint8_t buf[BLOCKSIZE];

   w25qReadPage(buf, address);

   for (ndx = 0; ndx < 5; ndx++)
   {
      uartSend(buf, BLOCKSIZE);

      address += BLOCKSIZE;
      w25qReadPage(buf, address);
   }
}
