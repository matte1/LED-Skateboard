/**************************************************************************/
/*!
    @file     cmd_ulog.c
    @author   Matthew Epperson

    @brief    Code to execute for cmd_reset in the 'core/cmd'
              command-line interpretter.
*/
/**************************************************************************/
#include <stdio.h>

#include "projectconfig.h"
#include "core/cmd/cmd.h"
#include "core/cpu/cpu.h"

#include "drivers/ulogfs/ulogfs.h"
#include "drivers/flash/w25qxx/w25qxx.h"

/**************************************************************************/
/*!
   @brief
*/
/**************************************************************************/
void cmd_ulog(uint8_t argc, char **argv)
{
   while (argc--)
      printf("%s\r\n", *argv++);

   if (!strcmp(argv[0], "start"))
   {
      w25qEraseChip();
      ulogInit();

      uint8_t buf[25];
      buf[0] = 0xAA;

      while(1)
      {
         if(mtk3339ParseNMEA())
         {
            mtk3339PackageData(buf+1);
            ulogBufferData(buf, 25);
         }
      }
   }
   else if (!strcmp(argv[0], "stop"))
   {
      
   }
   else if (!strcmp(argv[0], "play"))
   {
      ulogPrintFileSystem();
   }

}
