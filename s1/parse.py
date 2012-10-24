# -*- coding: utf-8 -*-
#import psyco
#psyco.full()

import sys

sys.path.append('../common')

from gen import go, GenerateIndex, Theme

# Все темы в порядке их следования в курсе
for fn in [
    Theme('Тестирующая система, алгоритмы, сложность, системы счисления', 'Понедельник - 7'),
    ("python.html", 2, 0, 0, 2),
    ("testsys.html", 0, 1, 0, 0),
    ("terminology.html", 0, 0, 0, 0),
    ("alg.html", 1, 0, 0, 1),
    #  ("pascal.html", 1, 0, 0, 1),
    #  ("delphi.html", 1, 0, 0, 1),
    ("radix.html", 1, 0, 0, 1),
    ("sort.html", 1, 0, 0, 1),
    ("binsearch.html", 1, 0, 0, 1),

    Theme('Представление чисел в памяти', 'Вторник - 6'),
    ("recurs.html", 1, 0, 0, 1),
    ("calc.html", 1, 2, 0, 1),
    ("long_ar.html", 1, 1, 0, 1),

    Theme('Алгоритмы на графах', 'Среда - 6'),
    ("data_structures.html", 1, 1, 0, 1),
    ("graph_alg.html", 2, 2, 0, 1),

    Theme('Динамическое программирование', "Четверг - 6"),
    ("dynamic1.html", 1, 0, 0, 1),
    ("dynamic_problems.html", 1, 4, 0, 1),

    Theme('Вычислительная геометрия', "Пятница - 7"),
    ("../s3/geom0.htm", 1, 1, 0, 1),
    ("integers.html", 2, 0, 0, 1),
    ("work1.html", 0, 1, 0, 1),
    ("work2.html", 0, 1, 0, 1),
    ("cryptography.html", 1, 0, 0, 1),

    Theme("Олимпиада", "Суббота - 4"),
    ("../s6/olymp.html", 0, 4, 0, 0),
]:
    go(fn)

GenerateIndex("Сессия 1 - весна (март): учебно-тематический план")