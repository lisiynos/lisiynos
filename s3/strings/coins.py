import time

input_file = open("coins.in", "r")
output_file = open("coins.out", "w")
line = input_file.readline().rstrip()
n, m = map(int, line.split())
line = input_file.readline().rstrip()
money = list(map(int, line.split())) * 2
our_list = []


def generate(prefix, m):
    if m == 0:
        our_list.append(prefix)
    else:
        prefix.append(0)
        generate(prefix, m - 1)
        prefix.pop()
        prefix.append(1)
        generate(prefix, m - 1)
        prefix.pop()


start = time.time()

generate([], 2 * m)
ans = []


if sum(money) < n:
    print(-1, file=output_file)
else:
    for i in range(len(our_list)):
        sum_1 = 0
        try_ans = []
        for j in range(len(our_list[i])):
            if our_list[i][j] == 1:
                sum_1 += money[j]
                try_ans.append(money[j])
        if sum_1 == n:
            ans.append(try_ans)
    if not ans:
        print(0, file=output_file)
    else:
        a = 0
        for i in range(len(ans)):
            if len(ans[i]) < len(ans[a]):
                a = i
        print(len(ans[a]), file=output_file)
        print(' '.join(map(str, ans[a])), file=output_file)

finish = time.time()
print(finish - start)


