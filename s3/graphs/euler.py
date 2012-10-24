# encoding: utf-8
import sys

sys.setrecursionlimit(100000)

sys.stdin = open("euler.in")
#sys.stdout = open("euler.out", "w")

# Поиск Эйлерова пути при помощи DFS
def dfs(v):
  for u in G[v]:
    if not (v,u) in P:
      P.add((v,u))
      P.add((u,v))
      dfs(u)
  ans.append(v)

while True:
  # Чтение исходных данных 
  try:
    n,m = map(int,input().split())
    print(n,m)
    G = [set() for i in range(n+1)]
    for i in range(m):
      v,u = map(int,input().split())
      G[v].add(u)
      G[u].add(v)
  except EOFError:
    break

  try:
    input() # Skip line
  except EOFError:
    pass
 
  cnt = 0
  first = -1
  for i in range(1,n+1):
    if len(G[i]) % 2 != 0:
      cnt += 1
      if first == -1:
        first = i

  if cnt > 2:
    print('Impossible')
    continue
    #exit()

  P = set()
  ans = []

  dfs(first)  
       
  ans.reverse()

  print(*ans)

