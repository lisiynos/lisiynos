import sys

sys.stdout = open("assert_demo2.html", "w")

for x in open("assert_demo.cpp"):
  print x.replace('<', '&lt;').replace('>', '&gt;'),