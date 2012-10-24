# -*- coding: utf-8 -*-

# Рекурсивное вычисление факториала
def fact(n):
    return n if n == 1 else n * fact(n - 1)


print(fact(6))

# Итеративное вычисление факториала
def fact2(n):
    res = 1
    for i in range(2, n + 1):
        res *= i
    return res


print(fact2(6))

from functools import reduce

# Использование reduce вычисление факториала
def fact3(n):
    return reduce(lambda x, y: x * y, range(2, n + 1))

print(fact3(6))



