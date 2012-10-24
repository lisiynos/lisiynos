# -*- coding: utf-8 -*-
#!/usr/bin/env python


def GCD(a, b):  # НОД (Наибольший Общий Делитель)
    # GCD - Greatest Common Divisor (Divide)
    if b == 0:
        return a
    else:
        # Переставляю переменные местами
        return GCD(b, a % b)

def GCD2(a, b):
    while a != b:
        if a > b:
            a -= b
        else:
            b -= a


# 120   >  50
# 120 % 50 = 20  < 50

a = 12000000000000000000000000
b = 5000000000000000000000
D = -10

print(GCD(a,b))
#for i in range(2, b + 1):
#    if (a % i == 0) and (b % i == 0):
#        D = i

print(D)

# НОК - Наименьшее Общее Кратное
# НОК(a,b) = a * b / НОД(a,b)



