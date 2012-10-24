from random import *

N = 100
MIN_X = -10000
MAX_X = 10000
MIN_Y = -10000
MAX_Y = 10000
# Генерируем N случайных точек
points = [(randrange(MIN_X, MAX_X), randrange(MIN_Y, MAX_Y)) for i in range(N)]


def area(p1, p2, p3):
    """ Площадь треугольника (через векторое произведение) """
    x1, y1 = p1
    x2, y2 = p2
    x3, y3 = p3
    # Получаем вектора
    ax, ay = x2 - x1, y2 - y1
    bx, by = x3 - x1, y3 - y1
    # Векторное произведение
    cross_product = ax * by - ay * bx
    # Возвращаем площадь
    return abs(cross_product / 2.0)


# Проверяем работу функции
assert area((0, 0), (0, 1), (1, 0)) == 0.5
assert area((1, 1), (1, 2), (3, 1)) == 1.0

S_max = 0
triangle = []  # Номера вершин треугольника с максимальной площадью

# Перебираем тройки точек
for i in range(N):
    for j in range(i + 1, N):
        for k in range(j + 1, N):
            S = area(points[i], points[j], points[k])
            if S > S_max:
                S_max = S
                # Запоминаем номера точек
                triangle = [i + 1, j + 1, k + 1]

print("Площадь =", S_max)
if S_max > 0:
    print("Номера точек:", *triangle)