# -*- utf-8 -*-
# Различные реализации QSort (сортировки Хоара)

from random import *


def qsort(A):
    """ Самая коротка рекурсивная реализация qsort на Python """
    # Если длина массива 0 или 1, то сразу возвращаем его как есть
    if len(A) <= 1:
        return A
    # Выбираем разделяющий элемент
    y = choice(A)
    # Делим массив на три куска и вызываем qsort для них
    return qsort([x for x in A if x < y]) + [x for x in A if x == y] + qsort([x for x in A if x > y])


# Генерируем случайный массив
A = [randint(-10 ** 10, 10 ** 10) for i in range(100000)]
assert qsort(A) == sorted(A)
