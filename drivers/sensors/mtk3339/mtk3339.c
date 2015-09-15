#include "mtk3339.h"
#include "core/systick/systick.h"

volatile bool nmeaBufferRdy = false;
volatile char nmeaBuffer[128];
static struct gps_t GPS;

/**************************************************************************/
/*!
   @brief Parses out an RMC message
      includes: time, lat, lon, vel, heading

   @param[in] nmea
      Pointer to start of nmea string message
*/
/**************************************************************************/
static bool _mtk3339ParseRMC(char *nmea)
{
   // UTC Time
	p = strchr(p, ',')+1;
	if (',' != *p)
		GPS.time = atof(p);

   // Check if data Valid
	p = strchr(p, ',')+1;
	if (',' != *p)
		if (p[0] != 'A')
         return false;

	// Latitude
	p = strchr(p, ',')+1;
	if (',' != *p)
		GPS.lat = atof(p);

	// Latitude sign
	p = strchr(p, ',')+1;
	if (',' != *p)
		if (p[0] == 'S')
         GPS.lat = -GPS.lat;

	// Longitude
	p = strchr(p, ',')+1;
	if (',' != *p)
      GPS.lon = atof(p);

	// Latitude sign
	p = strchr(p, ',')+1;
	if (',' != *p)
		if (p[0] == 'W')
         GPS.lon = -GPS.lon;

	// Velocity
	p = strchr(p, ',')+1;
	if (',' != *p)
      GPS.velocity = atof(p);

	// Heading
	p = strchr(p, ',')+1;
	if (',' != *p)
      GPS.heading = atof(p);

   #ifdef CFG_MTK3339_DEBUG
   printf("RMC - Time %d, Latitude %d, Longitude %d, Velocity %d, Heading %d%s",
      (int)GPS.time, (int)GPS.lat, (int)GPS.lon, (int)GPS.velocity,
      (int)GPS.heading, CFG_PRINTF_NEWLINE);
   #endif

   return true;
}

/**************************************************************************/
/*!
   @brief Parses out an GGA message
      includes: time, lat, lon, alt

   @param[in] nmea
      Pointer to start of nmea string message
*/
/**************************************************************************/
static bool _mtk3339ParseGGA(char *nmea)
{
   // UTC Time
	p = strchr(p, ',')+1;
	if (',' != *p)
		GPS.time = atof(p);

	// Latitude
	p = strchr(p, ',')+1;
	if (',' != *p)
		GPS.lat = atof(p);

	// Latitude sign
	p = strchr(p, ',')+1;
	if (',' != *p)
		if (p[0] == 'S')
         GPS.lat = -GPS.lat;

	// Longitude
	p = strchr(p, ',')+1;
	if (',' != *p)
      GPS.lon = atof(p);

	// Latitude sign
	p = strchr(p, ',')+1;
	if (',' != *p)
		if (p[0] == 'W')
         GPS.lon = -GPS.lon;

   // Skip three
   p = strchr(p, ',')+1;
   p = strchr(p, ',')+1;
   p = strchr(p, ',')+1;

	// Altitude
	p = strchr(p, ',')+1;
	if (',' != *p)
      GPS.alt = atof(p);

#ifdef CFG_MTK3339_DEBUG
   printf("GGA - Time %d, Latitude %d, Longitude %d, alt %d%s",
      (int)GPS.time, (int)GPS.lat, (int)GPS.lon, (int)GPS.alt, CFG_PRINTF_NEWLINE);
#endif
   return true;
}

/**************************************************************************/
/*!
   @brief Sends the starting NMEA strings to setup refresh rate of 1Hz and output
   of RMC

	1) Sets update to 1Hz
	2) Sets fix update rate to 1Hz
	3) Sets NMEA output to RMC only
*/
/**************************************************************************/
void mtk3339Init()
{
   // Set up gps struct
   memset(&GPS, 0, sizeof(GPS));

   // Set Update rate to 1HZ
   uartSend((uint8_t *)PMTK_SET_NMEA_UPDATE_1HZ, strlen(PMTK_SET_NMEA_UPDATE_1HZ));
   systickDelay(10);

   // Set FIX Update rate to 1HZ
   uartSend((uint8_t *)PMTK_API_SET_FIX_CTL_1HZ, strlen(PMTK_API_SET_FIX_CTL_1HZ));
   systickDelay(10);

   // Set to NMEA ouput to RMC only
   uartSend((uint8_t *)PMTK_SET_NMEA_OUTPUT_RMCONLY, strlen(PMTK_SET_NMEA_OUTPUT_RMCONLY));
   systickDelay(10);
}


/**************************************************************************/
/*!
   @brief Repacks gps struct into an array of bytes

   @param[in] buffer
      Serializes 6 floats into 24 byte buffer
*/
/**************************************************************************/
void mtk3339PackageData(uint8_t buffer[])
{
   memcpy(&buffer[0],  &GPS.time, 		sizeof(float));
   memcpy(&buffer[4],  &GPS.lat, 		sizeof(float));
   memcpy(&buffer[8],  &GPS.lon, 		sizeof(float));
   memcpy(&buffer[12], &GPS.alt, 		sizeof(float));
   memcpy(&buffer[16], &GPS.velocity, 	sizeof(float));
   memcpy(&buffer[20], &GPS.heading, 	sizeof(float));
}

/**************************************************************************/
/*!
   @brief Checks if there is any NMEA data to be parsed and what type of
	message is to be parsed.

   1. TODO: Examine whether or not the way uart indicates to this driver
   that there is data to be parsed is really the best way to be doing things.
   Right now it just says theres data if its seen a '*'.

   @return bool
      True if we actually parsed a nmea sentence.
*/
/**************************************************************************/
bool mtk3339ParseNMEA()
{
	char *p = (char *)nmeaBuffer;

   if (!nmeaBufferRdy)
      return false;

	if ((p = strchr(p, '$')))
   {
      p++;
      if(!strncmp(p, GPRMC, 5))
         _mtk3339ParseRMC(p);
      else if(!strncmp(p, GPGGA, 5))
         _mtk3339ParseGGA(p);
   }

   nmeaBufferRdy = false;
   // return true;
   return false;
}
