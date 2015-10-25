#!/usr/bin/python

import Packet
import threading, struct, time, os

logTestFile = "/home/matt/projects/ARM/lpc1114/ProSense/lpc21isp.log"

def parseLog(logfile):
    with open(logfile, 'rb') as log:
        while parseInode(log):
            print("Success")

''' Parse an Inode and start a thread to parse Data'''
def parseInode(log):
    try:
        result = False
        address = ((0xFFFFFFFF),)
        page = bytearray(log.read(256))

        # If we have an Inode then create file and parse data
        if page[0] == 0x01:
            ticks    = struct.unpack('>I', page[1:5])
            address  = struct.unpack('>I', page[13:17])
            size     = struct.unpack('>I', page[17:21])
            parseData(log, size[0], "test"+str(ticks[0])+".out")
        elif page[0] != 0x01:
            print("Bad Page ID")

    except Exception as ex:
        print("Inode Error: %s" % str(ex))

    return address[0] != 0xFFFFFFFF

def parseData(log, size, outfile):
    IMU = Packet.BNO055()
    GPS = Packet.MTK3339()

    with open(outfile, 'w') as out:
        try:
            while size > 0:
                packetID = bytearray(log.read(1))
                size -= 1
                if packetID[0] == 0xF0:
                    csv = IMU.parse(bytes(log.read(IMU.Length)))
                    out.write(csv)
                    size -= IMU.Length
                elif packetID[0] == 0xF1:
                    raise("Why the fuck is there a GPS Packet")
                else:
                    raise Exception("Invalid Packet ID (%s) at address %d" \
                         % (hex(packetID[0]), log.tell()))

            # Read out till next page
            data = bytes(log.read(1))
            while data[0] == 0xFF:
                data = bytes(log.read(1))
                if len(data) == 0:
                    print("Finished")
                    exit(1)
            log.seek(-1, 1)

        except Exception as ex:
            print("Data Error: %s" % str(ex))

def createDir():
    os.chdir("Matts-ProSense")
    newdir = time.asctime().replace("  ","_").replace(" ", "_")[4:]
    os.mkdir(newdir)
    print(newdir)
    os.chdir(newdir)

if __name__ == '__main__':
    parseLog(logTestFile)
    # parseData("../../lpc21isp.log", 256)
    # with open("../../lpc21isp.log", 'rb') as log:
    #     buf = bytes(log.read(12))
    #     for value in buf:
    #         print(value)
