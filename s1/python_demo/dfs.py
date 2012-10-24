# Смежность вершин
inc = {
    1: [2, 8],
    2: [1, 3, 8],
    3: [2, 4, 8],
    4: [3, 7, 9],
    5: [6, 7],
    6: [5],
    7: [4, 5, 8],
    8: [1, 2, 3, 7],
    9: [4],
}

visited = set()  # Посещена ли вершина?


# Поиск в глубину - ПВГ (Depth First Search - DFS)
def dfs(v):
    if v in visited:  # Если вершина уже посещена, выходим
        return
    visited.add(v)  # Посетили вершину v
    for i in inc[v]:  # Все смежные с v вершины
        if not i in visited:
            dfs(i)


start = 1
dfs(start)  # start - начальная вершина обхода
print(visited)