'''
This script calculates where the iteration error(error between the cordic and actual cos) reduces to below our resolution of Q2.14. It iterates over multiple angles, recording error at 8, 10, 12, 14 and 16 iterations, and then prints the max error at that angle
'''

import math

ROM = [11520, 6801, 3593, 1824, 916, 458, 229, 115, 57, 29, 14, 7, 4, 2, 1, 0] # rom taken directly from sim-py/rom-gen.py
angles = [-90, -60, -45, -30, 0, 30, 45, 60, 90]
iterations = [8, 10, 12, 14, 16]

for k in iterations: 
    errx = []
    erry = []
    for j in angles:
        y = 0 # 0 in Q2.14
        z = j*256 # 30 deg in Q8.8
        x = 9949 # 0.6073 in Q2.14, hardcoded instead of calculating it again and again
        x_new = 16384 # 1 in Q2.14
        cos = math.cos(math.radians(z/256)) # dividing by 256 to calculate actual values
        sin = math.sin(math.radians(z/256))

        for i in range(k):
            d = 1 if z>0 else -1
            x_new = x - d * (y >> i)
            y_new = y + d * (x >> i)
            z_new = z - d * ROM[i]
            x = x_new
            y = y_new
            z = z_new

        errx.append(abs(cos-(x/16384)))
        erry.append(abs(sin-(y/16384)))
    print(f"For Iteration: {k}")
    print(max(errx))
    print(max(erry))
    print()


'''
difference between errors of iteration 8 and 12 is much more than the difference between errors of iteration 12 and 16, thus i think 12 would be an optimal number of 
'''