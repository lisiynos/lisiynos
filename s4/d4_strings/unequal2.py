# Модифицируем предыдудщее решение
# Добавляем сортировку и вывод подстрок
import sys
sys.stdin = open("unequal2.in", "r")
sys.stdout = open("unequal2.out", "w")

st = input()
s = set()
l = len(st)
for i in range(l):
  for j in range(i+1, l+1):
    s.add(st[i:j])

# Выводим количество подстрок
print(len(s))
# Преобразуем в список и сортируем
# при помощи функции sorted()
for x in sorted(s):
  print(x)  