'''
Script generates the values for the tan-1 ROM on the ASIC
'''

import math

rom = []

for i in range(16):
    value = math.degrees(math.atan(2**-i))
    rom.append(round(value*256))

print(rom)