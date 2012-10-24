import sys
sys.stdin = open("rle.in")
#sys.stdout = open("rle.out", "w")

def python2():
  return sys.version < '3'


def inp():
  if sys.version < '3':
    return raw_input()
  else:
    return input()


print(sys.version)

k = int(inp())
a = list(map(int, inp().split()))

last = 0
cnt = 0
for i in range(len(a)):
  if a[i] != last or cnt == k:
    print(cnt, end=' ')
    last = a[i]
    cnt = 1
  else:
    last = a[i]
    cnt += 1
  

