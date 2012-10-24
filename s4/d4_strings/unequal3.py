import sys
sys.stdin = open("unequal3.in", "r")
sys.stdout = open("unequal3.out", "w")

st = input()
# В словаре будем хранить пары:
# строка => количество таких подстрок
d = dict()
l = len(st)
for i in range(l):
  for j in range(i+1, l+1):
    c = st[i:j]
    if c in d: 
      d[c] += 1
    else:
      d[c] = 1

print(len(d))
for x in sorted(d):
  print(x, d[x])  