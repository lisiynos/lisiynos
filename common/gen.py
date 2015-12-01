# -*- coding: utf-8 -*-
import os
from string import Template
from os import listdir
from os.path import isfile, join, dirname, realpath

# from BeautifulSoup import BeautifulSoup
from bs4 import BeautifulSoup

import sys

if sys.version < '3':
    reload(sys)  # Reload does the trick!
    sys.setdefaultencoding('UTF-8')


# Filter *.html files
def check_files(curFile):
    thisDir = dirname(realpath(curFile))  # __file__
    allFiles = set(f for f in listdir(thisDir) if isfile(join(thisDir, f)) and f.endswith(".html"))
    # allFiles.remove('index_template.html')
    allFiles.remove('index.html')
    print(allFiles)


def ReadTemplate(template_fn):
    return open('..\\common\\' + template_fn, 'r', encoding='utf8').read()


def GenFile(template, params, fn, overwrite=False):
    """
    Генерация файла
    :param template: шаблон
    :param params: параметры (словарь значений)
    :param fn: имя файла
    :param overwrite: перезаписывать если файл уже существует
    """
    if not overwrite and os.path.isfile(fn):
        return
    print('Generating "%s"...' % fn)
    if sys.version < '3':
        f = open(fn, 'w')
    else:
        f = open(fn, 'w', encoding='UTF-8')
    f.write(Template(template).safe_substitute(params))
    f.close()


# Шаблон одной строки при генерации таблицы
line_template = ReadTemplate("line_template.html")
chapter_template = ReadTemplate("chapter_template.html")
body = ""


# Статистика по одной сессии
class Session:
    all_theory = 0
    all_practice = 0

    def theme(self, theory, practice):
        self.all_theory += theory
        self.all_practice += practice

    def all_time(self):
        return self.all_theory + self.all_practice


# Сумма по стоблцам
session = Session()
session_dist = Session()

# Темы
tags = set()


# Тема
class Theme():
    def __init__(self, theme, title):
        self.theme = theme
        self.title = title


# Строка? Для Python2 и Python3
def isString(arg):
    if sys.version < '3':
        return isinstance(arg, basestring)
    else:
        return isinstance(arg, str)


# Read from file
def go(arg):
    global body, session, session_dist, tags

    if isString(arg):
        filename = arg
    elif isinstance(arg, Theme):
        d = {
            'theme': arg.theme,
            'title': arg.title,
        }
        res = Template(chapter_template).safe_substitute(d)
        body += "\n" + res
        return
    else:
        filename, theory, practic, theory_dist, practic_dist = arg

    if sys.version < '3':
        f = open(filename, "r")
    else:
        f = open(filename, "r", encoding='UTF-8')
    html = f.read()
    f.close()

    parsed_html = BeautifulSoup(html, "lxml")
    # Find hours and theme
    # print parsed_html.body.find('h1').text

    ul_tags = parsed_html.body.findAll(True, {'class': 'tags'})
    # print(str(ul_tags).encode('utf8').decode(sys.stdout.encoding))
    if len(ul_tags) == 0:
        print(filename)

    for item in ul_tags[0].findAll('a'):
        tags.add(item.text)
        # print u"Тема: ".encode('cp866'), item.text

    if isString(arg):
        theory = int(parsed_html.body.find('span', attrs={'class': 'theory'}).text)
        practic = int(parsed_html.body.find('span', attrs={'class': 'practic'}).text)
        theory_dist = int(parsed_html.body.find('span', attrs={'class': 'theory_dist'}).text)
        practic_dist = int(parsed_html.body.find('span', attrs={'class': 'practic_dist'}).text)
        print('theory = ' + theory + ' ' + theory_dist)
        print('practic = ' + practic + ' ' + practic_dist)


    # Выводить в index.html и генерировать описание
    d = {
        'theory': theory, 'practic': practic,
        'theory_dist': theory_dist, 'practic_dist': practic_dist,
        'sum': theory + practic,
        'dist': theory_dist + practic_dist,
        'filename': filename,
        'theme': parsed_html.body.find('h1').text,
    }
    # print d
    session.theme(theory, practic)
    session_dist.theme(theory_dist, practic_dist)
    # Заменяем все нули на &nbsp;
    if sys.version < '3':
        for k, v in d.iteritems():
            if v == 0:
                d[k] = '&nbsp;'
    else:
        for k, v in d.items():
            if v == 0:
                d[k] = '&nbsp;'

    res = Template(line_template).safe_substitute(d)
    if sys.version < '3':
        body += "\n" + res  # .encode('utf-8')
    else:
        body += "\n" + res


# print parsed_html.body.find('div', attrs={'class':'container'}).text

import color_console as cons


def Check(expected, actual, message):
    if actual != expected:
        default_colors = cons.get_text_attr()
        default_bg = default_colors & 0x0070
        cons.set_text_attr(cons.FOREGROUND_RED | default_bg | cons.FOREGROUND_INTENSITY)
        print('ERROR:', )
        cons.set_text_attr(default_colors)
        print(message % (expected, actual))


# Генеририрование index.html для конкретной сессии
def GenerateIndex(title):
    # Все проверки
    Check(18, session.all_theory, u'Теории на очной сессии должно быть %d часов, сейчас: %d')
    Check(36, session.all_time(), u'Всего на очной сессии должно быть %d часов, сейчас: %d')
    Check(18, session_dist.all_time(), u'Сумма по дистанционной сессии должна быть %d часов, сейчас: %d')

    themes = list(tags)
    themes.sort()
    # print (', '.join(themes)).encode("utf-8")
    print('Themes: %d' % len(themes))

    GenFile(ReadTemplate("index_template.html"),
            {
                'title': title,
                'body': body,  # .encode("utf-8"),
                'all_theory': session.all_theory,
                'all_practic': session.all_practice,
                'all_session': session.all_time(),
                'all_theory_dist': session_dist.all_theory,
                'all_practic_dist': session_dist.all_practice,
                'all_session_dist': session_dist.all_time(),
                'themes': (', '.join(themes)),
            },
            "index.html", True)

    # Показываем неиспользованные файлы
