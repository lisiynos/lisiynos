# -*- coding: utf-8 -*-
import sys

sys.path.append('../common')

from gen import go, GenerateIndex, Theme

# Все темы в порядке их следования в курсе
for fn in [
    Theme('Динамическое программирование', 'Понедельник - 7'),
    ("Info6.1.0.htm", 3, 4, 0, 4),

    Theme('Деревья', 'Вторник - 6'),
    ("segments_tree.html", 1, 2, 0, 3),
    ("treap.html", 1, 2, 0, 2),

    Theme('Максимальное паросочетание', 'Среда - 6'),
    ("bipartite_matching.html", 4, 2, 0, 3),

    Theme('Динамическое программирование', "Четверг - 6"),
    ("dynamic.html", 4, 2, 0, 4),

    Theme('Задача о замощении домино', "Пятница - 7"),
    ("domino.html", 5, 2, 0, 2),

    Theme("Олимпиада", "Суббота - 4"),
    ("../s6/olymp.html", 0, 4, 0, 0),
]:
    go(fn)

GenerateIndex("Сессия 5 - лето: учебно-тематический план")