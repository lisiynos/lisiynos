# -*- coding: utf-8 -*-
import sys

sys.path.append('../common')

from gen import go, GenerateIndex

# Все темы в порядке их следования в курсе
for fn in [
    ("strings.html", 4, 4, 1, 1),
    ("segment_tree_modification.html", 2, 3, 1, 1),
    ("trees.html", 5, 1, 1, 1),
    ('..\\s3\\segments_tree.html', 3, 2, 1, 2), # Структуры данных: дерево отрезков
    #("games.html", 2, 4, 1, 1),
    ("alg_number_theory.html", 4, 4, 2, 3), # Целочисленная арифметика, простые числа
    ("olymp.html", 0, 4, 0, 4), # Командная работа (решение олимпиад прошлых лет)
]:
    go(fn)

GenerateIndex("Сессия 6 - осень: учебно-тематический план")
