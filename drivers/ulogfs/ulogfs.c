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
      address = (buf[13] << 24) |
                (buf[14] << 16) |
                (buf[15] << 8)  |
                 buf[16];
   }

   address = uLogFS.lastInode;
   while (address < CFG_W25QXX_MAX_ADDRESS)
   {
      w25qReadPage(buf, address);

      if (_ulogCheckPage(buf))
         return address;

      address += SECTORSIZE;
   }

   // TODO: If it gets to here that means address is > max address. Should
   // return an error really.
   return address;
}


/**************************************************************************/
/*!
	@brief This will be called during system init in order to perpare for
   logging data. It will set a few variable such as curBlock and numBlocks

   TODO: 1) Add return codes for error handling. This could just return true
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
      printf("Init - CurBlock: %u%s", (unsigned int)uLogFS.curBlock,
         CFG_PRINTF_NEWLINE);
   #endif

   return 1;
}

/**************************************************************************/
/*!
   @brief Writes buffer ‘buffer’ of size ‘size’, which represents PART of a file’s
   content to the file system.

   NOTE: Need to flush data on the very last BufferData that is called

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
	@brief Creates a new file by writting a new Inode. There is a lot of unused
   space inside these Inodes that should be used to track file stats. Number
   of sectors used, time ended, last Inode for faster file searching.
*/
/**************************************************************************/
void ulogNewFile()
{
	uint8_t buf[13];
   uint32_t systime;

   systime = systickGetMillisecondsActive();

   buf[0] = BLOCK_TYPE_INODE;

   // Write Start Time
	buf[1] = (systime >> 24) & 0xFF;
   buf[2] = (systime >> 16) & 0xFF;
   buf[3] = (systime >> 8) & 0xFF;
   buf[4] =  systime & 0xFF;

   // TODO: Add GPS Time, Date if possible
   // if (gps_available)
   // {
   buf[5] = '1';
   buf[6] = '2';
   buf[7] = '3';
   buf[8] = '4';
   buf[9] = '5';
   buf[10] = '6';
   buf[11] = '7';
   buf[12] = '8';
   // }

   w25qWritePage(buf, uLogFS.curBlock, 13);

   // Update curBlock
   uLogFS.curBlock += BLOCKSIZE;
}

/**************************************************************************/
/*!
   @brief Cleans up after finished writing a file. This means flushing any
   data in the buffer. NOTE It also writes the next address back to the previous
   inode even if that new inode has not been created yet. Were making the
   assumption that it will be created
*/
/**************************************************************************/
void ulogCloseFile()
{
   uint32_t fileSize = uLogFS.curBlock - uLogFS.lastInode - BLOCKSIZE + uLogFS.bufferIndex;
   uint8_t buf[30];
   memset(buf, 0xFF, 30);

   // Flush any data in buffer
   if (uLogFS.bufferIndex > 0)
   {
   	w25qWritePage(uLogFS.buffer, uLogFS.curBlock, uLogFS.bufferIndex);
      uLogFS.curBlock += BLOCKSIZE;
      uLogFS.bufferIndex = 0;
   }

   // Make sure we are sector aligned for new file
   if (uLogFS.curBlock % SECTORSIZE != 0)
      uLogFS.curBlock = ((int)(uLogFS.curBlock / SECTORSIZE) + 1) * SECTORSIZE;

   // Setup data to write to last Inode
	buf[13] = (uLogFS.curBlock >> 24) & 0xFF;
   buf[14] = (uLogFS.curBlock >> 16) & 0xFF;
   buf[15] = (uLogFS.curBlock >> 8)  & 0xFF;
   buf[16] =  uLogFS.curBlock & 0xFF;

   buf[17] = (fileSize >> 24) & 0xFF;
   buf[18] = (fileSize >> 16) & 0xFF;
   buf[19] = (fileSize >> 8)  & 0xFF;
   buf[20] =  fileSize & 0xFF;

   // NOTE: This wont overwrite the first 13 bytes since unless some
   // of those bytes are 0xFF. But since we memset the array to 0xFF
   // anyways we should be good.
   w25qWritePage(buf, uLogFS.lastInode, 21);

   // Update where the last Inode was
   uLogFS.lastInode = uLogFS.curBlock;
}

/**************************************************************************/
/*!
   @brief Goes through file system and prints out all files and the
          time that they were created.
*/
/**************************************************************************/
void ulogListFiles()
{
   uint32_t fileTime, size, address = 0;
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

         // Size
			size = (buf[17] << 24) |
					 (buf[18] << 16) |
					 (buf[19] << 8)  |
					  buf[20];

         printf("Found File at Time %u at %u with a size %d%s", (unsigned int)fileTime,
				(unsigned int)address, (unsigned int)size, CFG_PRINTF_NEWLINE);

         // Next Address
			address = (buf[13] << 24) |
						 (buf[14] << 16) |
						 (buf[15] << 8)  |
						  buf[16];

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
   uint32_t address = 0, temp;
   uint8_t buf[BLOCKSIZE];

   // The second conditional is actually unnecassary
   while (address < CFG_W25QXX_MAX_ADDRESS && address != 0xFFFFFFFF)
   {
      // Get pointer to the next Inode
      w25qReadPage(buf, address);
      temp = address;
      address = (buf[13] << 24) |
                (buf[14] << 16) |
                (buf[15] << 8)  |
                 buf[16];

      while (temp < address && !_ulogCheckPage(buf))
      {
         uartSend(buf, BLOCKSIZE);
         temp += BLOCKSIZE;
         w25qReadPage(buf, temp);
      }
   }
}
