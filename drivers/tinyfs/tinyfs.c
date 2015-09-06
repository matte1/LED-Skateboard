#include "tinyfs.h"

static TINYFS TinyFS;
static FIL FileTable[MAX_FILES];
static uint8_t mount = 0x00;

/**************************************************************************/
/*! 
	@brief private helper method for writing a block of data in correct 
	tiny filesystem format to the memory chip.

	@param[in] filename 		
	         Name of the file to write to the inode

	@param[in] address
            address which to write Inode at
*/
/**************************************************************************/
static void _tfs_writeInode(char *filename, uint32_t address)
{
	uint8_t buf[TFS_INODESPACE];
   uint32_t start_block = address + BLOCKSIZE;
   uint32_t boottime; 

	buf[0] = BLOCK_TYPE_INODE;
	buf[1] = TINYFS_ID;
	buf[2] = 0xFF; 
	buf[3] = 0xFF;


   buf[20] = (start_block >> 24) & 0xFF;
   buf[21] = (start_block >> 16) & 0xFF;
   buf[22] = (start_block >> 8) & 0xFF;
   buf[23] = start_block & 0xFF;

   buf[24] = (address >> 24) & 0xFF;
   buf[25] = (address >> 16) & 0xFF;
   buf[26] = (address >> 8) & 0xFF;
   buf[27] = address & 0xFF;

   // buf[28] = (size >> 24) & 0xFF;
   // buf[29] = (size >> 16) & 0xFF;
   // buf[30] = (size >> 8) & 0xFF;
   // buf[31] =  size & 0xFF;

   boottime = systickGetSecondsActive();

   buf[32] = (boottime >> 24) & 0xFF;
   buf[33] = (boottime >> 16) & 0xFF;
   buf[34] = (boottime >> 8) & 0xFF;
   buf[35] =  boottime & 0xFF;

	strcpy((char *)&buf[8], filename);
   w25qWritePage(buf, address, TFS_INODESPACE);		
}

/**************************************************************************/
/*! 
	@brief private helper method for scanning the memory looking for last used
	block. This should only be used on boot to initialize the cache in SRAM

	@return address
         The address of the next avaliable block 
*/
/**************************************************************************/
static int _tfs_nextFreeBlock()
{
   int address = 0;
   uint8_t buf[BLOCKSIZE];

   buf[0] = 0;

   while (buf[0] != 0xFF)
   {
      w25qReadPage(buf, address);
      address += BLOCKSIZE;
   }

   return address - BLOCKSIZE;
}


/**************************************************************************/
/*! 
	@brief Makes a blank TinyFS file system of size nBytes on the file specified 
	by ‘filename’. This function should use the emulated disk library to open 
	the specified file, and upon success, format the file to be mountable. 
	This includes initializing all data to 0x00, setting magic numbers, initializing 
	and writing the superblock and inodes, etc. Must return a specified success/error 
	code. 

	@param[in] filename			
				The name of the file initialize as a tinyFS

	@param[in] nBytes
				The number of bytes to allocate for filesystem.

   @return TRESULT
            This always returns true. We would need to implement error checking for SPI 
            communication failure.
*/
/**************************************************************************/
TRESULT tfs_mkfs(char *filename, int nBytes)
{
	uint8_t buf[4] = {BLOCK_TYPE_SUPERBLOCK, 
		       		   TINYFS_ID, 
		       		   DEFAULT_ROOT_ADDRESS,
                     0xFF};

   // Initialize TINYFS struct
	TinyFS.id = 1;
	TinyFS.num_blocks = nBytes / BLOCKSIZE - 1;
	TinyFS.base_offset = 0;
   TinyFS.next_block = 0;

	// Clear chip for writing
	w25qEraseSector(0);
	// Write the First SuperBlock to Filesystem
   w25qWritePage(buf, 0, 4);

   return TR_OK;
}

/**************************************************************************/
/*! 
   @brief tfs_mount(char *filename) “mounts” a TinyFS file system located within ‘filename’. 
   tfs_unmount(void) “unmounts” the currently mounted file system. As part of the mount
   operation, tfs_mount should verify the file system is the correct type. Only one file 
   system may be mounted at a time. Use tfs_unmount to cleanly unmount the currently
   mounted file system. Must return a specified success/error code. 

   @return TRESULT
            If the filesystem has been initialized to a tinyfs then return ok
            If it hasnt been initialized or is already mounted return error
*/
/**************************************************************************/
TRESULT tfs_mount(void)
{
   uint8_t buf[BLOCKSIZE];

   w25qReadPage(buf, 0);

   if (buf[1] != TINYFS_ID || mount)
      return TR_BADFS;

   // Initialize FILE TABLE
   memset(FileTable, 0, sizeof(FIL)*MAX_FILES);
   mount = 1;

	return TR_OK;
}

TRESULT tfs_unmount(void)
{
   // Initialize FILE TABLE
   memset(FileTable, 0, sizeof(FIL)*MAX_FILES);
   
   mount = 0;
	return TR_OK;
}

/**************************************************************************/
/*! 
   @brief Opens a file for reading and writing on the currently mounted 
   file system. Creates a dynamic resource table entry for the file, 
   and returns a file descriptor (integer) that can be used to reference 
   this file while the filesystem is mounted. 
      
   @param[in] name
               The name of the file to open

   @return fileDescriptor
               Index into the FileTable corresponding to correct file
*/
/**************************************************************************/
fileDescriptor tfs_openFile(char *name)
{
   fileDescriptor fd;

   // Check to see if file is already open
   for(fd = 0; fd < MAX_FILES; fd++)
   {
      if (!strcmp(FileTable[fd].fname, name))
         return fd;
   }

   int address = 0;
   uint8_t buf[BLOCKSIZE];

   buf[0] = 0;

   // Find next avaliable spot in FileTable
   for (fd = 0; fd < MAX_FILES; fd++)
      if (!FileTable[fd].flag)
         break;

   // Walk through blocks to search for file inode
   while (buf[0] != 0xFF)
   {
      w25qReadPage(buf, address);

      if (buf[0] == BLOCK_TYPE_INODE)
      {
         if (!strcmp(name, (char *)&buf[8]) && buf[3] != TFS_DEADFILE) 
         {
            FileTable[fd].flag  =         TFS_ALIVEFILE;
         
            FileTable[fd].fsize =         (buf[28]<<24) |
                                          (buf[29]<<16) |
                                          (buf[30]<<8)  |
                                           buf[31];

            FileTable[fd].start_block =   (buf[20]<<24) |
                                          (buf[21]<<16) |
                                          (buf[22]<<8)  |
                                           buf[23];

            FileTable[fd].curr_block = FileTable[fd].start_block;

            FileTable[fd].inode_address = (buf[24]<<24) |
                                          (buf[25]<<16) |
                                          (buf[26]<<8)  |
                                           buf[27];

            FileTable[fd].fboottime =     (buf[32]<<24) |
                                          (buf[33]<<16) |
                                          (buf[34]<<8)  |
                                           buf[35];
            break;
         }
      }
      address += BLOCKSIZE;
   }

   strcpy(FileTable[fd].fname, name);

   // If File doesn't exist then create it
   if (FileTable[fd].flag != TFS_ALIVEFILE)
   {
      TinyFS.next_block = _tfs_nextFreeBlock();

      // Configure FileTable
      FileTable[fd].inode_address = TinyFS.next_block;
      FileTable[fd].start_block = FileTable[fd].curr_block = TinyFS.next_block + BLOCKSIZE;
      FileTable[fd].flag = TFS_ALIVEFILE;
   
      _tfs_writeInode(FileTable[fd].fname, TinyFS.next_block);

      TinyFS.next_block += BLOCKSIZE;
   }

	return fd;
}

/* Closes the file, de-allocates all system/disk resources, and removes 
 * table entry */
TRESULT tfs_closeFile(fileDescriptor fd)
{
   memset(&FileTable[fd], 0, sizeof(FIL));
	return TR_OK;
}

/**************************************************************************/
/*! 
   @brief Writes buffer ‘buffer’ of size ‘size’, which represents an entire file’s
   content, to the file system. Sets the file pointer to 0 (the start of file)
   when done. Returns success/error codes. MUST be called directly after openFile.
   This isn't a problem for data logging but could be for a more generic filesystem.

   @param[in] fd
         fileDescriptor to index into the File Table

   @param[in] buffer
         The data to be written as a file

   @param[in] size
         The size of the buffer

   @return TRESULT
         Always returns TR_OK, we would need to implement SPI error checking
         which would be a lower level than the filesystem
*/
/**************************************************************************/   
TRESULT tfs_writeFile(fileDescriptor fd, char *buffer, uint32_t size)
{
   uint8_t buf[BLOCKSIZE];
   uint8_t fsize[4];

   fsize[0] = (size<<24) & 0xFF;
   fsize[1] = (size<<16) & 0xFF;
   fsize[2] = (size<<8) & 0xFF;
   fsize[3] =  size & 0xFF;

   FileTable[fd].fsize = size;

   // Write size to inode
   w25qWritePage(fsize, FileTable[fd].inode_address + 28, 4);

	buf[0] = BLOCK_TYPE_EXTBLOCK;
	buf[1] = TINYFS_ID;
	buf[2] = 0xFF;
   buf[3] = 0xFF;

   while (1)
   {
      if (size > BLOCKSIZE - 4)
      {
         memcpy(&buf[4], buffer, BLOCKSIZE - 4);
         w25qWritePage(buf, TinyFS.next_block, BLOCKSIZE);  

         size -= BLOCKSIZE - 4;
         buffer += BLOCKSIZE - 4;
      }
      else
      {
         memcpy(&buf[4], buffer, size);
         w25qWritePage(buf, TinyFS.next_block, size + 4); 
         break;
      }
      TinyFS.next_block += BLOCKSIZE;
   }

	return TR_OK;
}

/**************************************************************************/
/*! 
   @brief Writes buffer ‘buffer’ of size ‘size’, which represents PART of a file’s
   content, to the file system. Note that this must be used after tfs_openFile
   without any other intervening calls.
   
   @param[in] fd
         fileDescriptor to index into the File Table

   @param[in] buffer
         Data to write to the file

   @param[in] numBlocks
         The number of blocks to add onto file.

   @return TRESULT
         Always returns TR_OK
*/
/**************************************************************************/   
TRESULT tfs_write(fileDescriptor fd, char *buffer, uint8_t numBlocks)
{
   uint8_t buf[BLOCKSIZE];

   buf[0] = BLOCK_TYPE_EXTBLOCK;
   buf[1] = TINYFS_ID;
   buf[2] = 0xFF;
   buf[3] = 0xFF;

   while (numBlocks--)
   {
      memcpy(&buf[4], buffer, BLOCKSIZE - 4);
      w25qWritePage(buf, TinyFS.next_block, BLOCKSIZE); 

      buffer += BLOCKSIZE - 4;
      TinyFS.next_block += BLOCKSIZE;
   }

   return TR_OK;
}


/**************************************************************************/
/*! 
   @brief deletes a file and marks its blocks as free on disk. This will be 
   done by writing a single byte to the inode of the file to mark its file as deleted.
   We cannot simply delete it because the smallest erase we can do is 4096 bytes

   @param[in] fd
         fileDescriptor to index into the File Table

   @return TRESULT
         TR_MSF if file does not exist
         TR_OK otherwise
*/
/**************************************************************************/   
TRESULT tfs_deleteFile(fileDescriptor fd)
{
   uint8_t buf = TFS_DEADFILE;

   if (FileTable[fd].flag != TFS_ALIVEFILE)
      return TR_MSF;

   w25qWritePage(&buf, FileTable[fd].inode_address+3, 1);
	return TR_OK;
}

/**************************************************************************/
/*! 
   @brief reads one byte from the file and copies it to buffer, using the current 
   file pointer location and incrementing it by one upon success. If the 
   file pointer is already at the end of the file then tfs_readByte() should  
   return an error and not increment the file pointer.

   @param[in] fd
         fileDescriptor to index into the File Table

   @param[in] buffer
         Pointer to the read buf

   @return TRESULT
         EOF if fptr is greater than file size
         OK otherwise
*/
/**************************************************************************/   
TRESULT tfs_readByte(fileDescriptor fd, char *buffer)
{
   uint8_t buf[BLOCKSIZE];
   uint8_t loc_offset;
   uint32_t address;

   if (FileTable[fd].fptr > FileTable[fd].fsize)
      return TR_EOF;

   address = FileTable[fd].start_block + FileTable[fd].fsize/BLOCKSIZE;
   loc_offset = FileTable[fd].fptr % BLOCKSIZE;

   w25qReadPage(buf, address);

   *buffer = buf[loc_offset];

   return TR_OK;
}

/**************************************************************************/
/*! 
   @brief change the file pointer location to offset (absolute). Returns success/error codes.
   This should really only change the fptr for the given FIL struct

   @param[in] fd
         fileDescriptor to index into the File Table

   @param[in] offset
         The byte offset into the file specified by fd

   @return TRESULT
         EOF if offset is greater than file size
         OK otherwise
*/
/**************************************************************************/   
TRESULT tfs_seek(fileDescriptor fd, int offset)
{
   if (offset > FileTable[fd].fsize)
      return TR_EOF;

   FileTable[fd].fptr = offset;

	return TR_OK;
}


/**************************************************************************/
/*! 
   @brief private helper method for scanning the memory looking for last used
   block. This should only be used on boot to initialize the cache in SRAM

   @return address
         The address of the next avaliable block 
*/
/**************************************************************************/
TRESULT tfs_listFiles()
{
   int address = 0;
   uint8_t buf[BLOCKSIZE];
   uint32_t boottime;

   buf[0] = 0;

   while (buf[0] != 0xFF)
   {
      w25qReadPage(buf, address);

      if (buf[0] == BLOCK_TYPE_INODE)
      {
         if (buf[3] != TFS_DEADFILE) 
         {
         boottime = (buf[32]<<24) |
                    (buf[33]<<16) |
                    (buf[34]<<8)  |
                     buf[35];

            printf("%s - %u seconds%s", &buf[8], (unsigned int)boottime, CFG_PRINTF_NEWLINE);
         }
      }
      address += BLOCKSIZE;
   }

   return TR_OK;
}

/**************************************************************************/
/*! 
   @brief private helper method for scanning the memory looking for last used
   block. This should only be used on boot to initialize the cache in SRAM

   @param[in] fd
         fileDescriptor to index into the File Table

   @return TRESULT
         Returns missing file error if no file present otherwise TR_OK 
*/
/**************************************************************************/
TRESULT tfs_printFile(fileDescriptor fd)
{
   uint8_t buf[BLOCKSIZE];
   uint32_t ndx, address;

   memset(buf, 0, BLOCKSIZE);
   address = FileTable[fd].start_block;

   if (FileTable[fd].flag != TFS_ALIVEFILE)
      return TR_MSF;

   w25qReadPage(buf, address);

   while (buf[0] == BLOCK_TYPE_EXTBLOCK)
   {
      for (ndx = 4; ndx < BLOCKSIZE && buf[ndx] != 0xFF; ndx++)
         printf("%c", (char)buf[ndx]);

      address += BLOCKSIZE;
      w25qReadPage(buf, address);
   }

   return TR_OK;
}