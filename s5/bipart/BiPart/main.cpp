// Максимальное паросочетание
#include <iostream>
#include <assert.h>
#include <stdio.h>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <stdlib.h>

using namespace std;

// Максимальное количество вершин в доле
const int maxN = 101;

// Рёбра из первой доли во вторую
vector<int> g[maxN];

// Размер первой доли, второй и количество рёбер
int m, n, k;

// -1 если нет ребра и номер вершины из
// A если есть ребро
int back[maxN];

int main() {
  freopen("bipart.in", "r", stdin);
  //freopen("bipart.out","w",stdout);
  // m - вершин в A
  // n - вершин в B
  // k - рёбер из A в B
  cin >> m >> n >> k;

  // Заполняем массив back -1
  fill(back, back + maxN, -1);

  // Вызываем dfs...
  // ...дописать...

  return 0;
}
