#!/usr/bin/env python

import sys
import sympy
from sympy import Integral, latex 

def main():
    t = sympy.Symbol('t')
    h = 1-sympy.exp(-t)

    console = sys.stdout                                     
    fo = open('t1.tex', 'w')                             
    sys.stdout = fo                                       
    print '$'+latex(h)+'$'
    print '$'+latex(h.diff(t),  )+'$'
    sys.stdout = console
    fo.close()   

    print h
    print h.diff(t)
#    print e.diff(b)
#    print e.diff(b).diff(a, 3)
#    print e.expand().diff(b).diff(a, 3)
    w = sympy.Symbol('w')
    j = sympy.Symbol('j')
    W = (2*j*w+8)/(j*w*(1+0.5*j*w)*(1+0.1*j*w)) 
    print W
    G = (2*w+8)*(-w)*(1-0.5*w)*(1-0.1*w)
    print G.expand()
    p = sympy.Symbol('p')
    J = p*(1+0.5*p)*(1+0.1*p)
    U = -2.8*w-0.1*w**3
    V = -8-0.8*w**2
    K = U*U+V*V
    print K.expand()
    R = V/U
    print R.expand()
    print latex(t**2)
    print latex(R)




if __name__ == "__main__":
    main()
