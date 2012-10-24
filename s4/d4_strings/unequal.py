# Различные подстроки
# Дана строка.
# Сколько различных подстрок, не считая пустой, она содержит?
import sys
sys.stdin = open("unequal.in", "r")
sys.stdout = open("unequal.out", "w")

st = input() # Строка
s = set() # Используем множества
l = len(st) # длина строки
for i in range(l):
  for j in range(i+1, l+1):
    s.add(st[i:j]) 
# len возвращает величину множества
print(len(s))