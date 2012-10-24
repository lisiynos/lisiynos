# -*- coding: utf-8 -*-
import sys

TASK = 'divisors'
sys.stdin = open(TASK + '.in')
sys.stdout = open(TASK + '.out', 'w')

n = int(input())
B = map(int, input().split())


def add(v):
    """ Добавляем простое число v в словарь d """
    if v in d:
        d[v] += 1
    else:
        d[v] = 1


d = {}

for x in B:
    for t in range(2, int(x ** 0.5 + 0.1)):
        while x % t == 0:
            add(t)
            x //= t
    if x > 1:
        add(x)

# v - количество вхождений
# k - простое число
res = [(v, k) for k, v in d.items()]
print(len(res))  # Количество делителей
for cnt, prime in sorted(res):
    print(prime, cnt)

