# -*- utf-8 -*-
# Проверка графа на двудольность (использование DFS)

import sys

sys.stdin = open("bipartite.in")


N,m = map(int, input().split())
G = [[] for i in range(N+1)

c = [-1] * N  # -1 - No color, 1 - first group, 2 - second

def dfs(v, color):
  c[v] = color  # Красим вершину
  for u in G[v]:
    if c[v] == c[u]:
      return False # Нашли цикл нечётной длины
    elif c[u] == -1: # Вершина u ещё не покрашена
      if not dfs(u, 3-color):
        return False
  return True 

# Запускаем по всем компонентам связности
for v in range(1,N+1):
  if c[v] == -1:
    dfs(v)


  
