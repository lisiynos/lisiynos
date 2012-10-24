from math import sqrt


class A:
    def __init__(self, name, age):
        self.name = name
        self.age = age


a = [A("Петя", 10), A("Вася", 15.3),
     A("Лена", 2.45), A("Галя", 10),
     A("Митя", 12)]
a.sort(key=lambda x: x.age)
for i in a:
    print(i.name, i.age)

b = [230.123, 234.22, 23.7, 6.3]
b.sort(reverse=True)
sortedB = sorted(b)
print(sortedB)


# Простые числа
# Простое число - делится только на себя и на 1
def is_simple(a):
    #  a = b * c
    s = int(sqrt(a)) + 1
    for p in range(2, s):
        if a % p == 0:
            return False
    return True


# Проверяем работу нашей функции
for n in range(1, 20):
    print(n, is_simple(n))


