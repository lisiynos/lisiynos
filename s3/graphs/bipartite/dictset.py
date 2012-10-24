colors = [1, 2, 2, 3, 1]


d = {}
for i in range(n):
  index = i
  color = colors[i]
  if color in d:
    d[color].add(i)
  else:
    d[color] = set(i)