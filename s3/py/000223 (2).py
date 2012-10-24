k = int(input())
a = list(map(int, input().split()))
last = 0
cnt = 0
a = a[:-1]
for i in range(len(a)):
  if (cnt == k or a[i] != last):
    if cnt:
      print(cnt, end=' ')
    if (cnt == k):
      print(0, end=' ')
    last = a[i]
    cnt = 1
  else:
    cnt += 1
if cnt:
  print(cnt)

