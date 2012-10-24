# -*- utf-8 -*-
# Задача 4B. "Гемоглобин"

import sys

TASK = 'hemoglobin'
sys.stdin = open(TASK + '.in')
sys.stdout = open(TASK + '.out', 'w')

# Частичные суммы
S = [0]

# Количество обращений к базе данных
N = int(input())
for i in range(N):
    q = input().rstrip()
    if q[0] == '+':
        k = int(q[1:])
        S.append(S[-1] + k)
    elif q[0] == '?':
        k = int(q[1:])
        print(S[-1] - S[-k - 1])
    elif q[0] == '-':
        print(S[-1] - S[-2])
        S.pop()



