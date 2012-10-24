# -*- utf-8 -*-
# Полиномиальное хеширование строк

from math import *


def is_prime(a):
    """ Простое ли число a? """
    return all(a % i for i in range(2, int(sqrt(a) + 0.1) + 1))

# Генерируем все простые числа < 100
primes = [x for x in range(2, 100) if is_prime(x)]
print(*primes)

# Простые числа больше миллиарда
primes = [x for x in range(10 ** 9, 10 ** 9 + 1000) if is_prime(x)]
print(*primes)

# Пусть есть некоторая строка s
s = 'abacaba'

P = 10 * 9 + 7
b = 29

# Считаем заранее все степени
base = [0] * len(s)
base[0] = 1
for i in range(1, len(s)):
    base[i] = (base[i - 1] * b) % P


def hash_slow(s):  # Прямое вычисление хеша
    res = 0  # Здесь будет хеш строки s
    # Пробегаем по всем символам
    for i in range(len(s)):
        res = (res + ord(s[i]) * base[i]) % P
    return res


# Прямое вычисление хеша
def hash_prefix(s):
    h = [0] * len(s)
    res = 0  # Здесь будет хеш строки s
    # Пробегаем по всем символам
    for i in range(len(s)):
        res = (res + ord(s[i]) * base[i]) % P
        h[i] = res
    return h


h = []


def hash(s, i, j):
    # Вычисляем Prefix
    res = 0
    h = [0] * len(s)
    for i in range(len(s)):
        res = (res + ord(s[i]) * base[i]) % P

    h = [ord(s[i])]


    # import sys

    # sys.stdin = open('partition.in')
    # sys.stdout = open('partition.out', "w")