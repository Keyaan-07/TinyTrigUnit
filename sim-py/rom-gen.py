'''
Script generates the values for the tan-1 ROM on the ASIC
'''

import math

rom = []

for i in range(12):
    value = math.degrees(math.atan(2**-i))
    rom.append(round(value*256))

for i in rom:
    print(f"16'd{i}", end=", ")