def lower_bound(sorted_list, x):
    left = -1
    right = len(sorted_list)

    while right - left > 1:
        middle = (right + left) // 2
        print(middle)
        if sorted_list[middle] >= x:
            right = middle
            print('right =', right, sorted_list[left:right])
        else:
            left = middle
            print('left =', left, sorted_list[left:right])

    if right == len(sorted_list):
        return None
    else:
        return right


B = [1, 2, 3]

print(lower_bound(sorted(B), 2))