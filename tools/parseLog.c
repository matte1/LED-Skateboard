#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void parseEuler(FILE *inputFile)
{
   int ndx;
   unsigned int temp;
   uint8_t rawdata[6];
   int16_t data[3];

   for (ndx = 0; ndx < 6; ndx++)
   {
      fscanf(inputFile, "  %x", &temp);
      fgetc(inputFile);

      rawdata[ndx] = (uint8_t)temp;
   }

   data[0] = ((int16_t)rawdata[1] << 8) | rawdata[0];
   data[1] = ((int16_t)rawdata[3] << 8) | rawdata[2];
   data[2] = ((int16_t)rawdata[5] << 8) | rawdata[4];
   printf("%f %f %f\n", (float)data[0]/16, (float)data[1]/16, (float)data[2]/16);
}

void parseGPS(FILE *inputFile)
{
   int ndx = 0, idx = 0;
   uint8_t rawdata[4];

   for (ndx = 0; ndx < 24; ndx++)
   {
      fscanf(inputFile, " %x", &rawdata[idx]);
      idx++;
      if (idx == 4)
      {
         printf("%f\n", *(float *)rawdata);
         idx = 0;
      }
   }
}

int main(int argc, char **argv)
{
   FILE *inputFile;
   inputFile = fopen(argv[1],"rw+");

   unsigned int data = 0;
   uint8_t msgType;

   while(fscanf(inputFile, " %x", &data) != EOF)
   {
      //fgetc(inputFile);

      msgType = (uint8_t)data;
      printf("MSGTYPE: %x\n", msgType);
      switch (msgType)
      {
         case 0xC1:
            parseEuler(inputFile);
            break;
         case 0xAA:
            parseGPS(inputFile);
            break;
         default:
            printf("Error: Unknown Message Type %X\n", msgType);
            break;
      }
   }

   fclose(inputFile);
   return 0;
}
