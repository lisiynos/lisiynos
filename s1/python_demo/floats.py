# -*- coding: utf-8 -*-
#!/usr/bin/env python


def equal(a, b):
    """ Равенство с учётом погрешности """
    return abs(a - b) < 1e-15  # 0.0000000000000001


a, b, c = 1, 2, -3

from math import *

D = b * b - 4 * a * c
if equal(D, 0):
    x = -b / (2 * a)
    print("x =", x)
    print(a * x * x + b * x + c)
elif D > 0:
    x1 = (-b + sqrt(D)) / (2 * a)
    x2 = (-b - sqrt(D)) / (2 * a)
    print("x1 =", x1, " x2 =", x2)
    print(a * x1 * x1 + b * x1 + c)
    print(a * x2 * x2 + b * x2 + c)
else:
    print("Решений нет")

