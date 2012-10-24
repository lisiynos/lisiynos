N = 4
Inf = float("Inf")
print(Inf)

A = [[0] * N for i in range(N)]

for k in range(N):
    for i in range(N):
        for j in range(N):
            if A[i][k] + A[k][j] < A[i][j]:
                A[i][j] = A[i][k] + A[k][j]


