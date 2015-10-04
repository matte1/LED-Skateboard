#!/usr/bin/python

import Packet
import threading, struct, time, os

logTestFile = "~/projects/ARM/lpc1114/ProSense/lpc21isp.log"

''' Parse an Inode and start a thread to parse Data'''
def parseInode(logfile, address):
    with open(logfile, 'rb') as log:
        # Move to next address and read a page
        log.seek(address)
        page = bytearray(log.read(256))

        # If we have an Inode then create file and parse data
        if page[0] == 0x01:
            ticks = struct.unpack('<I', page[1:5])
            utc = struct.unpack('<I', page[9:13])
            parseData(logfile, "test"+str(ticks[0])+".out", log.tell())
            # Make file from date and time
            # newThread = threading.Thread(target=parseData(logfile, fi.tell()))
            # newThread.start()
        else:
            raise Exception("No Inode Found at %d" % address)

        # Check if there is another Inode
        address = struct.unpack('>I', page[5:9])
        print(hex(address[0]))
        # if address[0] != 0xFFFFFFFF:
        #     print(address)
        #     parseInode(logfile, address[0])

def parseData(logfile, outfile, address):
    IMU = Packet.BNO055()
    GPS = Packet.MTK3339()

    with open(logfile, 'rb') as log, open(outfile, 'w') as out:
        try:
            log.seek(address)

            while True:
                packetID = bytearray(log.read(1))
                if packetID[0] == 0xF0:
                    csv = IMU.parse(bytes(log.read(16)))
                    print(csv)
                    out.write(csv)
                elif packetID[0] == 0xF1:
                    raise("Why the fuck is there a GPS Packet")
                else:
                    raise Exception("Invalid Packet ID (%s) at address %d" \
                         % (hex(packetID[0]), log.tell()))

        except Exception as ex:
            print("Data Error: %s" % str(ex))


def run(logfile):
    parseInode(logfile, 0)
    parseData(logfile, 256)

def createDir():
    os.chdir("Matts-ProSense")
    newdir = time.asctime().replace("  ","_").replace(" ", "_")[4:]
    os.mkdir(newdir)
    print(newdir)
    os.chdir(newdir)

if __name__ == '__main__':
    # parseInode(logTestFile, 0)
    # parseData("../../lpc21isp.log", 256)
    # with open("../../lpc21isp.log", 'rb') as log:
    #     buf = bytes(log.read(12))
    #     for value in buf:
    #         print(value)
