# -*- utf-8 -*-
# Задача Золотой песок

import sys

TASK = 'dust'
sys.stdin = open(TASK + '.in')
sys.stdout = open(TASK + '.out', 'w')

N, W = map(int, input().split())
A = []
for i in range(N):
    v, w = map(int, input().split())
    # Если вес 0 => то такого песка просто нет
    if w == 0:
        continue
    cost = v / w
    A.append((cost, v, w))

# Сортируем кортежи, сначала самый дорогой песок
A.sort(reverse=True)

ans = 0.0
for cost, v, w in A:
    # Если мы можем положить весь песок => складываем
    if W >= w:
        W -= w
        ans += v
    else:
        ans += cost * W
        break
    if W == 0:
        break
print(ans)

