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
	@brief Checks a page of data to see if its empty or has data in it.

	@return bool
         True if page is empty
*/
/**************************************************************************/
static bool _ulogCheckPage(uint8_t buf[])
{
   int ndx;

   for (ndx = 0; ndx < 256; ndx++)
      if (buf[ndx] != 0xFF)
         break;

   return ndx == 256;
}

/**************************************************************************/
/*!
	@brief This assumes a that the next free block is unkown and scans from
   beginning of memory trying to find the next free sector.

   NOTE: This is defenitely broken... If we unluckily get a sector that has
   data in but starts with 0xFF then were SOL.

   1. Traverse to last inode
   2. Iterate through sectors until next free one

	@return address
         The address of the next avaliable block
*/
/**************************************************************************/
static uint32_t _ulogNextFreeSector()
{
   // int ndx = 0;
   uint32_t address = 0;
   uint8_t buf[BLOCKSIZE];

   // The second conditional is actually unnecassary
   while (address < CFG_W25QXX_MAX_ADDRESS && address != 0xFFFFFFFF)
   {
      // Get pointer to the next Inode
      w25qReadPage(buf, address);
      uLogFS.lastInode = address;
      address = (buf[5] << 24) |
                (buf[6] << 16) |
                (buf[7] << 8)  |
                 buf[8];
   }

   printf("New Sector Address found: %u\n\r", (unsigned int)uLogFS.lastInode);

   address = uLogFS.lastInode;
   while (address < CFG_W25QXX_MAX_ADDRESS)
   {
      w25qReadPage(buf, address);

      if (_ulogCheckPage(buf))
         return address;

      // for (ndx = 0; ndx < 256; ndx++)
      // {
      //    if (buf[ndx] != 0xFF)
      //       break;
      // }
      //
      // if (ndx == 256)
      // {
      //    printf("Found free sector\n");
      //    return address;
      // }

      address += SECTORSIZE;
   }

   return address;
}


/**************************************************************************/
/*!
	@brief This will be called during system init in order to perpare for
   logging data. It will set a few variable such as curBlock and numBlocks

   TODO: 1) Find where the last Inode is at.
         2) Add return codes for error handling. This could just return true
         if there is room avaliable and false if not

   @return 1
*/
/**************************************************************************/
uint8_t ulogInit()
{
   uLogFS.lastInode = 0;
   uLogFS.bufferIndex = 0;
	uLogFS.curBlock = _ulogNextFreeSector();

   #ifdef CFG_ULOGFS_DEBUG
      printf("Init Block: %u%s", (unsigned int)uLogFS.curBlock,
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
	   w25qWritePage(uLogFS.buffer, uLogFS.curBlock, BLOCKSIZE);
      memcpy(uLogFS.buffer, &data[spaceLeft], length - spaceLeft);
      uLogFS.bufferIndex = length - spaceLeft;
	   uLogFS.curBlock += BLOCKSIZE;
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
   	w25qWritePage(uLogFS.buffer, uLogFS.curBlock, uLogFS.bufferIndex);
      uLogFS.curBlock += BLOCKSIZE;
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
   if (uLogFS.curBlock % SECTORSIZE != 0)
      uLogFS.curBlock = ((int)(uLogFS.curBlock / SECTORSIZE) + 1) * SECTORSIZE;

   w25qWritePage(buf, uLogFS.curBlock, 5);

   #ifdef CFG_ULOGFS_DEBUG
      printf("Created new file at: %u\n\r", (unsigned int)uLogFS.curBlock);
   #endif

	buf[5] = (uLogFS.curBlock >> 24) & 0xFF;
   buf[6] = (uLogFS.curBlock >> 16) & 0xFF;
   buf[7] = (uLogFS.curBlock >> 8) & 0xFF;
   buf[8] =  uLogFS.curBlock & 0xFF;

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
   if (uLogFS.curBlock != 0)
      w25qWritePage(buf, uLogFS.lastInode, 9);
   // Update where the last Inode was
   uLogFS.lastInode = uLogFS.curBlock;
   // Update curBlock
   uLogFS.curBlock += BLOCKSIZE;
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
*/
/**************************************************************************/
void ulogPrintFileSystem()
{
   // int ndx = 0;
   uint32_t address = 0, temp;
   uint8_t buf[BLOCKSIZE];

   // The second conditional is actually unnecassary
   while (address < CFG_W25QXX_MAX_ADDRESS && address != 0xFFFFFFFF)
   {
      // Get pointer to the next Inode
      w25qReadPage(buf, address);
      temp = address;
      address = (buf[5] << 24) |
                (buf[6] << 16) |
                (buf[7] << 8)  |
                 buf[8];

      while (temp < address && !_ulogCheckPage(buf))
      {
         uartSend(buf, BLOCKSIZE);
         temp += BLOCKSIZE;
         w25qReadPage(buf, temp);
      }
   }
}
