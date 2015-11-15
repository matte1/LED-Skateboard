# ProSense
Version: 1.0.0

## Firmware

#### FIX THAT BAD DATA ID BUG
1. Add ECC?
2. Does it change all thereafter IDs?
3. Is it repetitive or completely random?
4. Race condition?
5. **BAD SOLDER CONNECTION!!** I havent seen the problem on the other board
which has a better solder joint

#### Short Term Goals:
1. Write errors to new file inside post processing.
2. python parse time/date from GPS message
3. Time Sampling: Incorporate GPS Time and System Ticks
   - Could easily just tag 4 bytes in each packet for time. Then during
   post processing use GPS time as base

#### Medium Goals
1. Python serial CLI or GUI for interacting with device
   - Play with pySerial and see if the board can be reset
   - Add features file browsing, start/stop recording, etc

#### Long Term Goals
1. Add Bluetooth LE firmware support

## Hardware

#### Short Term Goals:
1. **REWIRE LIPO**

#### Medium Goals
1. ~~Find new GPS unit~~ UBLOX M8
2. ~~Find QFN LPC1114 source~~ Mouser FHI33/302

#### Long Term Goals
1. Add Bluetooth chip
