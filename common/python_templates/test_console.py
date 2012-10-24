"""
Test module color_console (Python 2.6). Does not work with Python 3.0 (mainly
due to the usage of print. In Python 3.0 print is a builtin function and no more
a statement.
$Id: test26_color_console.py 534 2009-05-10 04:00:59Z andre $
"""

import sys
sys.path.append('../')

import color_console as cons

def test():
  """Simple test for color_console."""
  default_colors = cons.get_text_attr()
  default_bg = default_colors & 0x0070
  cons.set_text_attr(cons.FOREGROUND_BLUE | default_bg |
                     cons.FOREGROUND_INTENSITY)
  print '==========================================='
  cons.set_text_attr(cons.FOREGROUND_BLUE | cons.BACKGROUND_GREY |
                     cons.FOREGROUND_INTENSITY | cons.BACKGROUND_INTENSITY)
  print 'And Now for Something',
  cons.set_text_attr(cons.FOREGROUND_RED | cons.BACKGROUND_GREY |
                     cons.FOREGROUND_INTENSITY | cons.BACKGROUND_INTENSITY)
  print 'Completely Different!',
  cons.set_text_attr(default_colors)
  print
  cons.set_text_attr(cons.FOREGROUND_RED | default_bg |
                     cons.FOREGROUND_INTENSITY)
  print '==========================================='
  cons.set_text_attr(default_colors)

if __name__ == "__main__":
  test()