# -*- utf-8 -*-
#import sys

#sys.stdin = open("brackets.in")
#sys.stdout = open("brackets.out", "w")
#n = int(input())

# Количество пар скобок
n = 4


def gen(index=0, br_open=0, br_close=0, ans=['_'] * (2 * n)):
    if index == 2 * n:
        print("".join(ans))
        return
    if br_open < n:
        ans[index] = '('
        gen(index + 1, br_open + 1, br_close, ans)
    if br_close < br_open:
        ans[index] = ')'
        gen(index + 1, br_open, br_close + 1, ans)


gen()