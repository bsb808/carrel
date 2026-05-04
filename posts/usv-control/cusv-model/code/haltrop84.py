import math

def ASC(R,x):
    ''' Area of circle section '''
    return R**2*math.acos((R-x)/R) - (R-x)*sqrt(2*R*x - x**2)

# Implementation of Haltrop 1984 method for drag estimate
L = 12.2
B = 3.34
T = 1.2
rho = 1024.0
# Waterplane area
Awp = 7/8*L*B
# Effective radius for use in calculated section area using circle segment
alpha = 1.1
Reff = (alpha*B)/2.0
# Max. section area - based on circle section
Ax = ASC(Reff, T)
# Displacement volume
gamma = 0.875
D = gamma*Ax*L
# Mass
m = D*rho


# Prismatic coefficient
Cp = D/(Ax*L)
# Block coefficient
Cb = D/(L*B*T)
# Waterplane coefficient
Cwp = Awp/(L*B)
# Midship section area coefficient
Cm = Ax/(B*T)
# For normal stern shape
c14 = 1.0
LR = L*(1-Cp)
# The (1+k) term - from Haltrop 84
onepk = 0.93 + 0.487118*c14*(B/L)**1.06806*(T/L)**0.46106*(L/LR)**0.121563*(L**3/D)**0.36486*(1-Cp)**(-0.604247)
# From Haltrop 82
lcb = 0.0
iE = 1 + 89.0*exp(-(L/B)**0.80856*(1-Cwp)**0.30484*(1-Cp-0.0225*lcb)**0.6367*(LR/B)**0.34574*(100*D/L**3)**0.16302)

# Wave making resistance
# for Fn > 0.55
c17 = 6919.3*Cm**(-1.3346)*(D/L**3)**2.00977*(L/B-2.0)**1.40692
m3 = -7.2035*(B/L)**0.325869*(T/B)*0.605375
c7 = 0.229577*(B/L)**0.33333
if B/L > 0.11:
    c7 = B/L
if B/L > 0.25:
    c7 = 0.5-0.0625*L/B
    
c1 = 2223105*c7**3.78613*(T/B)**1.07961*(90-iE)**(-1.37565)
c3 = 1.0 # Ignoring bulbous bow?
c5 = 1.0 # Ignoreing reduction to transom stern?
#c2 = exp(-1.89*sqrt(c3))
c2 = 1.0
lamb = 1.446*Cp-0.03*(L/B)
if L/B > 12.0:
    lamb = 1.446*Cp-0.36
d = -0.9
c15 = -1.69385
if (L**3/D) > 512:
    c15 = -1.69385 + (L/D**(1.0/3)-8)/2.36
if (L**3/D) > 1726.91:
    c15 = 0.0
c16 = 8.07981*Cp-13.8673*Cp**2+6.984388*Cp**3
if Cp > 0.8:
    c16 = 1.73014-0.7076*Cp
m1 = 0.0140407*L/T-1.75254*D**(1.0/3)/L-4.79323*B/L-c16

U = 1.0
g = 9.81
Fn = U/(sqrt(g*L))
m4 = c15*0.4*exp(-0.034*Fn**(-3.29))

Rwa = c1*c2*c5*D*rho*g*exp(m1*Fn**d+m4*cos(lamb/Fn**2))
# For Fn > 0.55
Rwb = c17*c2*c5*D*rho*g*exp(m3*Fn**d+m4*cos(lamb/Fn**2))

# Wetted surface area of hull - from Haltrop 82
Cm = 0.75
Cb = 0.66
Cwp = 0.875
S = L*(2*T+B)*sqrt(Cm)*(0.453+0.4425*Cb-0.2862*Cm-0.003467*B/T+0.3696*Cwp)
S/V**(2.0/3.0)     

def u2f(u):
    # U to Froude
    L = 12.2
    g = 9.81
    return u/sqrt(g*L)

def f2u(f):
    # Froude to U
    L = 12.2
    g = 9.81
    return f*sqrt(g*L)

# ITTC 1957
nu = 1.0e-6
UU = [2.2, 3.3]
Cf = []
Re = []
for U in UU:
    Re.append(U*L/nu)
    Cf.append(0.075/(log10(Re[-1])-2)**2)

# Drag quadratic coefficient
Ct = 4.5e-3
S = 51
D = 0.5*Ct*rho*S



# Check the results in paper, 1984, Section 5
'''
m4c = 0.3279
m3f = -3.31
c17 = 1.41
c2 = 1.0
c5 = 0.7329
D = 900.0
Rwb_verify = c17*c2*c5*D*rho*g*exp(m3f+m4c)
'''
