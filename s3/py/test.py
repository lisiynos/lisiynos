# Генерация скобочных последовательностей


def bracket(n):
    """ Прямой рекурсивный перебор """
    assert n > 0
    if n == 1:
        return ['()']
    # Исключить повторение: ()()()  [()][()()]  + [()()][()]
    res = set()
    for l in bracket(n - 1):
        res.add('(' + l + ')')
    for i in range(n - 1, 0, -1):
        # Перемножаем множества
        for l1 in bracket(i):
            for l2 in bracket(n - i):
                res.add(l1 + l2)
    return sorted(res)


print(bracket(3))


def gen(n, index, br_open, br_close, ans):
    if index == 2 * n:
        print("".join(ans))
        return
    if br_open < n:
        ans[index] = '('
        gen(n, index + 1, br_open + 1, br_close, ans)
    if br_open > br_close:
        ans[index] = ')'
        gen(n, index + 1, br_open, br_close + 1, ans)


def gen_brackets(n):
    s = ["_"] * 2 * n
    gen(n, 0, 0, 0, s)


gen_brackets(3)
# T(n) - число Каталана, количество правильных скобочных последовательностей
# с n-парами скобок