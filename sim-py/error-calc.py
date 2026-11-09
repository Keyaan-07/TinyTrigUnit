'''
This script calculates where the iteration error(error between the cordic and actual cos) reduces to below our resolution of Q2.14
'''

import math

iterations = [8, 10, 12, 14, 16]
errx = 0

for j in iterations:
    y = 0
    z = 30
    x = 1
    x_new = 1.0
    cos = math.cos(math.radians(z))
    sin = math.sin(math.radians(z))

    for i in range(j):
        x *= math.cos(math.atan(2**-i))

    for i in range(j):
        d = 1 if z>0 else -1
        x_new = x - d * (y / 2**i)
        y_new = y + d * (x / 2**i)
        z_new = z - d * math.degrees(math.atan(2**-i))
        x = x_new
        y = y_new
        z = z_new

    errx = abs(cos-x)
    erry = abs(sin-y)
    print(f"For iterations: {j}")
    print(errx)
    print(erry)
    print()
