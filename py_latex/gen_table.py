# Генерация таблицы значений для построения графика
from math import *
fout = open("atan.table", "wt")
x1 = -3.0; x2 = 3.0; n = 60
h = (x2 - x1) / n
for k in range(n + 1):
  x = x1 + k * h
  print >>fout, "%.4f %.4f" % (x, atan(x))