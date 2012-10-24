# -*- utf-8 -*-
# Задача 4A "Телефонные номера"

import sys

TASK = 'tele'
sys.stdin = open(TASK + '.in')
sys.stdout = open(TASK + '.out', 'w')


# N цифр и нужна сумма K
N, K = map(int, input().split())

# F[l][s] - количество способов получить номер из l цифр с суммой s
F = [[0] * (K + 1 + 10) for i in range(N + 1)]
# База динамики - пустой номер с суммой 0 получается одним способом
F[0][0] = 1
for l in range(0, N):
    for s in range(0, K + 1):
        for last in range(10):  # Последняя цифра
            F[l + 1][s + last] += F[l][s]

print(F[N][K])




