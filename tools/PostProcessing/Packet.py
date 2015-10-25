#!/usr/bin/python

import struct

class Packet(object):
    """Class interface for digesting bytearrays"""
    def __init__(self, ):
        self.values = []

    def unpack(self, buf):
        pass

    def toCSV(self):
        csv = ""
        for value in self.values:
            csv += "{:10.4f}".format(value) + ',' 
        csv = csv[:-1]+"\n"

        del self.values[:]
        return csv

    def parse(self, buf):
        self.unpack(buf)
        return self.toCSV()


class BNO055(Packet):
    pkt_fmt = '<hhhhhhI'
    pkt_size = struct.calcsize(pkt_fmt)
    Length = 16

    def __init__(self):
        Packet.__init__(self)

    def unpack(self, buf):
        del self.values[:]

        if len(buf) != BNO055.pkt_size:
            print(BNO055.pkt_size)
            raise Exception("bad packet")

        raw = struct.unpack(BNO055.pkt_fmt, buf)
        self.values.append(float(raw[0])/100.0)
        self.values.append(float(raw[1])/100.0)
        self.values.append(float(raw[2])/100.0)
        self.values.append(float(raw[3])/16.0)
        self.values.append(float(raw[4])/16.0)
        self.values.append(float(raw[5])/16.0)
        self.values.append(raw[6])

class MTK3339(Packet):
    pkt_fmt = '<I'
    pkt_size = struct.calcsize(pkt_fmt)

    def __init__(self):
        Packet.__init__(self)

    def unpack(self, buf):
        pass
