#!/usr/bin/python
# -*- coding: UTF-8 -*-

import codecs, sys

reload(sys)
sys.setdefaultencoding('utf-8')

print sys.getdefaultencoding()

if sys.platform == 'win32':
    try:
        import win32console 
    except:
        print "Python Win32 Extensions module is required.\n You can download it from https://sourceforge.net/projects/pywin32/ (x86 and x64 builds are available)\n"
        exit(-1)
    # win32console implementation  of SetConsoleCP does not return a value
    # CP_UTF8 = 65001
    win32console.SetConsoleCP(65001)
    if (win32console.GetConsoleCP() != 65001):
        raise Exception ("Cannot set console codepage to 65001 (UTF-8)")
    win32console.SetConsoleOutputCP(65001)
    if (win32console.GetConsoleOutputCP() != 65001):
        raise Exception ("Cannot set console output codepage to 65001 (UTF-8)")

#import sys, codecs
sys.stdout = codecs.getwriter('utf8')(sys.stdout)
sys.stderr = codecs.getwriter('utf8')(sys.stderr)

print "Привет"
print u"Привет"
print (u"Привет").encode('cp437')