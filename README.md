# ProSense
Version: 1.0.0

## Firmware

#### NOTES
- Need to find a place for packaging data into chunks of storable data. The best place for this may actually be in each driver file since data packaging will be data specific or there could be a layer in between that would handle data packaging to make it more device agnostic.

- To display what the chips is seeing plug TX from GPS to RX on chip and RX from Host to TX of Chip only. What this means for Hardware setup is that we won't be able to do much direct testing on host. Need to first log data to flash then play it back to really see it.


#### Short Term Goals:
2. Improve ulogfs
   - ~~Need to actually make it handle files~~
   - ~~align files by sectors so it can be deleted.~~
3. Create layer between acquiring sensor data and packaging
4. Create CLI interface for ulogfs
   - Start, stop, download
1. Record GPS data to flash and play back to google earth.
   - ~~Wire up gps to proto board~~
   - ~~Write *time*, *lat*, *long*, with a new message type to flash.~~
      - ~~Need to enforce RMC only (TEST)~~
      - ~~Rewrite parse NMEA functions to allow greater flexibility (TEST)~~
      - ~~Rewrite how NMEA data is stored and transfered to data to memory~~ (TEST)
   - Add additional terminal interface function for starting/stopping/erasing ulogfs
      - PROBLEM: Bus contention between GPS and Terminal.
   - ~~Output as hexdump to host.~~
      - Need to restructure format with message IDs
      - Tighten up how the logfs prints out data
   - ~~Reassamble as floats~~
   - Construct csv file from data
   - Parse csv to kml and upload to google earth
5. Record IMU data to flash and play back to Unity
   - Parse output into correct rpy laccel quat

###### TEST STEPS
1. Record Data
   - GPS FIX
   - No interface
   - Erase flash
   - Init flash
   - Record
2. Play back
   - Dont erase flash
   - Spit out data to file
   - parse


#### Medium Goals
1. Python serial CLI or GUI for interacting with device
   - Play with pySerial and see if the board can be reset
   - Add features file browsing, start/stop recording, etc
2. Write Task Scheduler
   - GPS 10hz, IMU 100hz, Baro ?
3. Formalize method of retreiving data and serializing across all devices
4. Create method for time stamping that incorporates GPS Time and System Ticks
5. Improve file system. Need to add file removal support

#### Long Term Goals
1. Add Bluetooth LE firmware support

## Hardware

#### Components
- LPC1114

#### Short Term Goals:
1. **REWIRE LIPO**
2. ~~Buy new parts from mouser~~
3. ~~Layout board in Eagle and buy.~~
4. ~~Figure out why flash isn't working~~ WRONG SPI MODE

#### Medium Goals
1. Find new GPS unit
2. ~~Find QFN LPC1114 source~~ Mouser FHI33/302
3. Replace W25Qxx with a package that doesnt have leads

#### Long Term Goals
1. Add Bluetooth chip
2. Add Baro
