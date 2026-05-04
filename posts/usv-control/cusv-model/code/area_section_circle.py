import math
R = 1.0
x = 0.5

def ASC(R,x):
    return R**2*math.acos((R-x)/R) - (R-x)*sqrt(2*R*x - x**2)

def nASC(R,x):
    ''' Normalized '''
    return ASC(R,x)/(pi*R**2)


X = linspace(0,2*R,100)
nasc = []
narect = []

for x in X:
    nasc.append(nASC(R,x))
    Arect = x*2*R
    narect.append(Arect/(pi*R**2))
figure(1)
clf()
plot(X,nasc, label='Segment')
#plot(X,X/2.0,'k:', label='Line')
plot(X,narect,'r:', label='Rectangular')
legend()
xlabel(r'Draft/Radius, $T/R$ [n/a]')
ylabel(r"Normalized Area, $\bar{A} = A_{segment}/A_{circle}$ [n/a]")
grid(True)
show()
