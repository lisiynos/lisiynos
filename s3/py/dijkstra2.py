# -*- utf-8 -*-

# Алгоритм Дейкстры
from tkinter import Pack

N, M, start = map(int, input().split())
E = [] * N
for i in range(M):
    f, t, w = map(int, input().split())
    # Неориентированный граф
    E[f].append((t, w))
    E[t].append((f, w))

INF = 10 ** 10  # Бесконечность
d = [INF] * N  # Кратчайшее расстояние до первой вершины
Colored = [False] * N  # Когда нашли кратчайший путь -> красим вершину
Path = [-1] * N  # Предыдущая вершина

add = start
min_d = 0
while min_d != INF:
    # Добавляем новую вершину
    Colored[add] = True
    d[add] = min_d
    # Пересчитываем пути через вершину add
    for t, w in E[add]:
        if d[add] + w < d[t]:
            d[t] = d[add] + w
            Path[t] = add
    # Ищем минимум
    min_d = INF
    for i in range(N):
        if not Colored[i] and d[i] < min_d:
            min_d = d[i]
            add = i

# Трёхмерная динамика во Флойде
# [k][i][j] - используя вершины с 1-ой по k-ую
d = [[[0] * (N + 1) for i in range(N + 1)] for j in range(N + 1)]
for k in range(1, N + 1):
    for i in range(1, N + 1):
        for j in range(1, N + 1):
            d[k][i][j] = min(d[k - 1][i][j], d[k - 1][i][k] + d[k - 1][k][j])

# Сведение к квадратной матрице
F = [[0] * (N + 1) for i in range(N + 1)]
for k in range(1, N + 1):
    for i in range(1, N + 1):
        for j in range(1, N + 1):
            F[i][j] = min(F[i][j], F[i][k] + F[k][j])

# Флойд с восстановлением пути
F = [[0] * (N + 1) for i in range(N + 1)]
prev = [list(range(N + 1)) for i in range(N + 1)]
for k in range(1, N + 1):
    for i in range(1, N + 1):
        for j in range(1, N + 1):
            if F[i][k] + F[k][j] < F[i][j]:
                F[i][j] = F[i][k] + F[k][j]
                prev[i][j] = prev[k][j]


def show_path(i, j):
    k = prev[i][j]
    if k == i:
        print(i, end=' ')
        return
    show_path(i, k)
    show_path(k, j)
