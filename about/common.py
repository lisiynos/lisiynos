# -*- coding: utf-8 -*-
import sys

sys.path.append('../common')

from BeautifulSoup import BeautifulSoup

import glob

tags = set()

#sessions = ['s1', 's2', 's3', 's4', 's5', 's6']
sessions = ['s1']

for session_dir in sessions:
    dir_name = "../" + session_dir + "/*.html"
    print dir_name
    for filename in glob.glob(dir_name):
        if filename.endswith('index.html'):
            continue
        print filename
        f = open(filename, "r")
        html = f.read()
        f.close()

        parsed_html = BeautifulSoup(html)
        # Find hours and theme
        #print parsed_html.body.find('h1').text

        for item in parsed_html.body.findAll(True, {'class': 'theme'}):
            tags.add(item.text)
            print u"Тема: ", item.text

def x(theme, theory, practice):
    if theme in tags:
       pass
    else:
       print theme
             
x(u'АЛГОРИТМЫ ТЕОРИИ ЧИСЕЛ', 8, 10)
x(u'Алгоритмы над целыми числами', 4, 4)
x(u'Длинная арифметика', 2, 3)
x(u'Криптография', 2, 3)
x(u'КОМБИНАТОРИКА И ТЕОРИЯ ВЕРОЯТНОСТЕЙ. МЕТОД МОНТЕ-КАРЛО', 14, 14)
x(u'Базовые идеи комбинаторики', 2, 2)
x(u'Рекурсия и рекуррентные соотношения', 4, 6)
x(u'Переборные алгоритмы', 4, 4)
x(u'Метод Монте-Карло', 4, 2)
x(u'ТЕОРИЯ ГРАФОВ', 14, 12)
x(u'Классические идеи теории графов', 4, 0)
x(u'Алгоритмы на графах', 4, 4)
x(u'Деревья в программировании', 2, 2)
x(u'Динамическое программирование', 4, 6)
x(u'ВЫЧИСЛИТЕЛЬНАЯ ГЕОМЕТРИЯ', 8, 8)
x(u'Основные геометрические понятия', 3, 0)
x(u'Отношения между геометрическими объектами', 3, 2)
x(u'Построение выпуклой оболочки', 2, 2)
x(u'Задачи с использованием геометрических понятий', 0, 4)
x(u'Логика', 4, 6)
x(u'Булева алгебра и построение логических схем', 2, 3)
x(u'Алгебра логики', 5, 6)
x(u'ЯЗЫКИ И ГРАММАТИКИ', 7, 3)
x(u'Компьютерное представление и обработка формул', 1, 2)
x(u'Конечные автоматы', 2, 1)
x(u'Машины Тьюринга и система Поста', 4, 0)