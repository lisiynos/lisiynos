# -*- utf-8 -*-
# Задача 3C "Папа Коли"

import sys

TASK = 'father'
sys.stdin = open(TASK + '.in')
sys.stdout = open(TASK + '.out', 'w')

sys.setrecursionlimit(100500)

# Количество работников
N = int(input())
# Непосредственные подчинённые
E = [[] for i in range(N + 1)]

if N > 1:
    # Схема подчинения
    A = list(map(int, input().split()))
    for i in range(len(A)):
        f = A[i]  # Начальник
        t = i + 2  # Подчинённый
        E[f].append(t)

# Ответ будем записывать тут
ans = [0] * N


def dfs(v):
    res = 0
    for u in E[v]:
        res += 1 + dfs(u)
    ans[v - 1] = res
    return res


dfs(1)
print(*ans)




