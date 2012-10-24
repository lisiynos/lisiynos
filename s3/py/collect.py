a, b = map(int, input().split())

cnt = 0
while b:
  cnt += a // b
  a, b = b, a % b
print(cnt)
