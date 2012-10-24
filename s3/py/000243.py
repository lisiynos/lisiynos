k = int(input())
a = list(map(int, input().split()))
a = a[:-1]
last = 0
if a[0] == 2:
  exit(0)
last = a[0]
cnt = 1
for i in range(len(a)):
  if cnt == k or a[i] != last:
    if cnt == k:
      print(cnt, 0, end= ' ')
    else:
      print(cnt, end = ' ' )
  else:
    cnt += 1
if cnt:
  print(cnt)