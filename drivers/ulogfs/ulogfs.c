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

   TODO: Add return codes for error handling. This could just return true
   if there is room avaliable and false if not
   @return 0
*/
/**************************************************************************/
uint8_t ulogInit()
{
	uLogFS.nextBlock = _ulogNextFreeBlock();
   uLogFS.bufferIndex = 0;
   uLogFS.lastInode = 0;

   printf("Init Block: %u%s", (unsigned int)uLogFS.nextBlock,
      CFG_PRINTF_NEWLINE);

   return 1;
}

/**************************************************************************/
/*!
   @brief Writes buffer ‘buffer’ of size ‘size’, which represents PART of a file’s
   content, to the file system. Note that this must be used after ulog_openFile
   without any other intervening calls.

   @NOTE: Need to flush data on the very last BufferData that is called

   @param[in] data
         Data to write to the file

   @param[in] length
         Data to write to the file

   @return uint8_t
      	Returns a status message.
*/
/**************************************************************************/
uint8_t ulogBufferData(uint8_t *data, int length)
{
   int spaceLeft = BLOCKSIZE - uLogFS.bufferIndex;

   // printf("Buffer, nextBlock %u\r\n", (unsigned int)uLogFS.nextBlock);
   // printf("Spaceleft %u\r\n", (unsigned int)spaceLeft);
   // printf("length %u\r\n", (unsigned int)length);
   // printf("index %u\r\n", (unsigned int)uLogFS.bufferIndex);

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
      memcpy(uLogFS.buffer, data + length - spaceLeft, length - spaceLeft);
      uLogFS.bufferIndex = length - spaceLeft;
	   uLogFS.nextBlock += BLOCKSIZE;
   }

   return 0;
}

/**************************************************************************/
/*!
   @brief Writes any data stored in buffer to the flash chip and resets
   the index back to 0.
*/
/**************************************************************************/
void ulogFlushData()
{
   printf("\n\rbufferIndex %u\n\r", (unsigned int)uLogFS.bufferIndex);
   printf("nextBlock %u\n\r", (unsigned int)uLogFS.nextBlock);


   if (uLogFS.bufferIndex > 0)
   {
      printf("Flushing\r\n");
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

   // TODO: Add GPS Time, Date if possible
   // TODO: CREATE MACRO FOR PACKING/UNPACKING bytes to uint32
	buf[1] = (systime >> 24) & 0xFF;
   buf[2] = (systime >> 16) & 0xFF;
   buf[3] = (systime >> 8) & 0xFF;
   buf[4] =  systime & 0xFF;

   // Make sure we are sector aligned
   if (uLogFS.nextBlock % SECTORSIZE != 0)
      uLogFS.nextBlock = ((int)(uLogFS.nextBlock / SECTORSIZE) + 1) * SECTORSIZE;

   // Create New file inode for this file
   printf("Created file at %u%s", (unsigned int)uLogFS.nextBlock, CFG_PRINTF_NEWLINE);
   w25qWritePage(buf, uLogFS.nextBlock, 5);


   printf("Last Inode at %u%s", (unsigned int)uLogFS.lastInode, CFG_PRINTF_NEWLINE);

	buf[5] = (uLogFS.nextBlock >> 24) & 0xFF;
   buf[6] = (uLogFS.nextBlock >> 16) & 0xFF;
   buf[7] = (uLogFS.nextBlock >> 8) & 0xFF;
   buf[8] =  uLogFS.nextBlock & 0xFF;

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
   @brief deletes a file and marks its blocks as free on disk. This will be
   done by writing a single byte to the inode of the file to mark its file as deleted.
   We cannot simply delete it because the smallest erase we can do is 4096 bytes

   @TODO: DO, This will probably look like an Inode being the start of a file
   with Sector enforcement meaning allocate a sector at a time for a file so its
   easier to cleanup in the end. Meaning worst case scenario 4k loss of space.

*/
/**************************************************************************/
void ulogDeleteFile()
{

}

/**************************************************************************/
/*!
   @brief private helper method for scanning the memory looking for last used
   block. This should only be used on boot to initialize the cache in SRAM

   @return address
         The address of the next avaliable block
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
   @brief Prints out all blocks of data
*/
/**************************************************************************/
void ulogPrintFileSystem()
{
   int i;
   uint32_t address = 0;
	uint8_t buf[BLOCKSIZE];

   w25qReadPage(buf, address);

   while (buf[0] != 0xFF && address < CFG_W25QXX_MAX_ADDRESS)
   {
      for (i = 0; i < BLOCKSIZE; i++)
         printf("%X ", buf[i]);

      printf("%s%s", CFG_PRINTF_NEWLINE, CFG_PRINTF_NEWLINE);
      address += BLOCKSIZE;
      w25qReadPage(buf, address);
   }
}
