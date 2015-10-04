# ProSense
Version: 1.0.0

## Firmware

#### Short Term Goals:
1. python parse time/date from GPS message
1. Reiterate with Casey on FileSystem
1. Create CLI interface for ulogfs
   - Start, stop, download
2. Record IMU data to flash and play back to Unity
   - Parse output into correct rpy laccel quat
3. Time Sampling: Incorporate GPS Time and System Ticks
   - Could easily just tag 4 bytes in each packet for time. Then during
   post processing use GPS time as base

#### Medium Goals
1. Port BLE code
2. Python serial CLI or GUI for interacting with device
   - Play with pySerial and see if the board can be reset
   - Add features file browsing, start/stop recording, etc
3. Write Task Scheduler
   - GPS 10hz, IMU 100hz, Baro ?

#### Long Term Goals
1. Add Bluetooth LE firmware support

## Hardware

#### Short Term Goals:
1. **REWIRE LIPO**

#### Medium Goals
1. Find new GPS unit
2. ~~Find QFN LPC1114 source~~ Mouser FHI33/302
4. Add RGB LED

#### Long Term Goals
1. Add Bluetooth chip
2. Add Baro
3. Add button that can be held down to toggle power.
