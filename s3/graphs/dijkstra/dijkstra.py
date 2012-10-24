# -*- utf-8 -*-

import sys
sys.stdin = open("dijkstra.in")
sys.stdout = open("dijkstra.out", "w")

N,M,start = map(int, input().split())
# Списки ребёр
G = [[] for i in range(N+1)]
for i in range(M):
  i,j,w = map(int, input().split())
  G[i].append((j,w))
  G[j].append((i,w))


INF = 10**10
# d[i] - кратчайшее расстояние до вершины i
d = [INF] * (N+1)  
used = [False] * (N+1)  # Посетили ли вершину i?
add = start # Добавляем начальную вершину
min_d = 0 # Расстояние до неё - 0
Prev = [-1] * (N+1)

while min_d != INF:
  # Добавляем вершину add к множеству вершин, 
  # до которых посчитано кратчайшее расстояние
  used[add] = True
  d[add] = min_d
  # Пересчитываем пути проходящие через add
  for t,w in G[add]:
    if d[add] + w < d[t]:
      d[t] = d[add] + w
      Prev[t] = add
  # Ищем непокрашенную вершину с минимальным d
  min_d = INF
  for i in range(1, N+1):
    if not used[i] and d[i] < min_d:
      min_d = d[i] # Запоминаем новое минимальное расстояние
      add = i    # И вершину i надо добавить

def ShowPath(v):
  j = v 
  Path = [j]
  while j != start:
    j = Prev[j]
    Path.append(j)
  Path.reverse()
  print(d[v],*Path)

# Выводим расстояние и путь до каждой вершины от начальной
for i in range(1, N+1):
  ShowPath(i)
 
   

