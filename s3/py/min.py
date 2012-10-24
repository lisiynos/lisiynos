# -*- utf-8 -*-
# Задача 5A. "Минимум на отрезке"

import sys

TASK = 'min'
sys.stdin = open(TASK + '.in')
sys.stdout = open(TASK + '.out', 'w')


def read_ints():
    return list(map(int, input().split()))


# Количество населённых пунктов и дорог
N, M = read_ints()
G = [[] for i in range(N + 1)]
for j in range(M):
    f, t, w = read_ints()
    G[f].append((t, w))
    G[t].append((f, w))
is_city = [-1] + read_ints()

INF = 10 ** 10
d = [INF] * (N + 1)
used = [False] * (N + 1)
add = 0
min_d = INF

# Дейкстра
# Для всех городов ставим 0
for i in range(1, N + 1):
    if is_city[i] == 1:
        d[i] = 0
        add = i
        min_d = 0

# Добавляем первый город
used[add] = True

while min_d != INF:
    used[add] = True
    # Пересчитываем пути через add
    for t, w in G[add]:
        d[t] = min(d[t], d[add] + w)
    # Ищем минимум среди d
    min_d = INF
    for i in range(1, N + 1):
        if d[i] < min_d and not used[i]:
            min_d = d[i]
            add = i

for i in range(1, N + 1):
    if d[i] == INF:
        print(-1, end=' ')
    else:
        print(d[i], end=' ')