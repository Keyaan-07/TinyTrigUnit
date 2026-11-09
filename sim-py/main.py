import math 
x=1
y=0
z=30
x_new = 1.0


precision = 25 # in bits
for i in range(precision):
    x *= math.cos(math.atan(2**-i))

for i in range(precision):
    d = 1 if z>0 else -1
    x_new = x - d * (y / 2**i)
    y_new = y + d * (x / 2**i)
    z_new = z - d * math.degrees(math.atan(2**-i))
    x = x_new
    y = y_new
    z = z_new
    
print(x)
print(y)