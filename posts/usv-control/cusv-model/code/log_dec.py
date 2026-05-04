# Logarithmic Decrement

## Pitch
# Assume we have a plot of y(t) vs t
# Location of first peak as tuple
y0 = (27.8, 0.37)
# Location of second peak as tuple
yN = (32.47, 0.026)
# Number of oscillations between peaks
N = 3
# Final value
fv = 0.0

## Roll
y0 = (42.8, 0.568)
yN = (44.7, 0.382)
N = 3
fv = 0.0

'''
## Heave
y0 = (13.0, 1.81)
yN = (18.97, -0.375)
N = 3
fv = -0.56
'''

########################################
# Period
T = (yN[0] - y0[0]) / N
d = 1.0/N*log( (y0[1]-fv) / (yN[1]-fv) )
z = 1.0 / sqrt( 1 + (2*pi/d)**2 )
wd = 2.0*pi/T
wn = wd/sqrt(1-z**2)
