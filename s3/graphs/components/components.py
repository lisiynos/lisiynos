from sys import setrecursionlimit
setrecursionlimit(100500)


def dfs(v, color):
    if used[v]:
        return
    used[v] = True
    c[v] = color
    components[color].append(v)
    for u in E[v]:
        dfs(u, color)

fin = open('components2.in', 'r')
fout = open('components2.out', 'w')

n, m = map(int, fin.readline().rstrip().split())
used = [False] * n
c = [0] * n
components = [[] for i in range(n)]
E = [[] for i in range(n)]
for i in range(m):
    x, y = map(int, fin.readline().rstrip().split())
    E[x - 1].append(y - 1)
    E[y - 1].append(x - 1)
color = 0
for v in range(n):
    if not used[v]:
        color += 1
        dfs(v, color)
fout.write(str(max(c)))
mm = max(c)
for c in range(1,color):
    fout.write('\n' + len(components[c]))
    fout.write('\n' + ' '.join(list(map(str, sorted(components[c])))))
fin.close()
