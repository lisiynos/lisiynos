from collections import deque

A, B = map(int, input().split())

dist = [10**10] * 10000

dist[A] = 0
q = deque()
q.append(A)
while len(q):
  v =   q.popleft()
  if v == B:
    print("Yes")
    exit(0)

  u = (7*v+2) % 10000
  if dist[v] + 1 < dist[u]:
    dist[u] = dist[v] + 1
    q.append(u)

  u = (2*v+7) % 10000
  if dist[v] + 1 < dist[u]:
    dist[u] = dist[v] + 1
    q.append(u)

print("No")
