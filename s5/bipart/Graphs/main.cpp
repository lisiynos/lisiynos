// Раскраска графа в 2 цвета
#include <iostream>
#include <assert.h>
#include <stdio.h>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <stdlib.h>

using namespace std;

// Максимальное количество вершин
const int maxN = 101;

int N = 3;

// g[i] - список вершин смежных с данной
vector<int> g[maxN];

// color[i] - цвет вершины i
int color[maxN];

// Depth First Search
int dfs(int n, int c) {
  assert(c == 1 || c == 2);
  // TODO: обработать этот случай
  assert(color[n] == 0); // Вершина не покрашена
  // Красим в нужный цвет
  color[n] = c;
  // Всех соседей крашу в другой цвет
  int c2 = 3 - c; // Цвета 1 и 2, поэтому другой цвет 3-с
  assert(c2 != c); // Должен быть другой цвет
  for(int j = 0; j < g[n].size(); ++j) {
    int v = g[n][j];
    if(color[v] == c2)
      continue;
    if(color[v] == c)
      return 0;
    if(!dfs(v, c2))
      return 0;
  }
  return 1;
}

// Для отладки можно использовать
#define DEBUG

int main() {
  // Отладочный вывод
#ifdef DEBUG

#endif
  freopen("task.in", "r", stdin);
  //freopen("task.out","w",stdout);
  // Проверка утверждения
  //assert(2*2 == 4);
  /*
   Работа с set
   set<int> s;
   s.insert(2);
   s.insert(3);
   s.insert(2);

  // Итераторы
   cout << "Size: " << s.size() << endl;
   for(set<int>::iterator i = s.begin(); i != s.end(); i++){
       cout << *i << endl;
   }

   // Работа с map
   map<int,string> m;
   m[2] = "222";
   for(map<int,string>::iterator i =
       m.begin(); i != m.end(); i++){
       cout << i->first << " " << i->second << endl;
   } */
  // Вершины + рёбра
  int m;
  cin >> N >> m;
  // Считываем рёбра
  for(int i = 0; i < m; ++i) {
    int a, b;
    cin >> a >> b;
    g[a].push_back(b);
    g[b].push_back(a);
  }
  // Много компонент связности
  for(int i = 1; i <= N; ++i)
    if(!color[i]) // Не покрашена вершина
      if(!dfs(i, 1)) { // Красим в 1-ый цвет
        // Не удалось покрасить
        cout << -1 << endl;
        return 0;
      }

  // Выводим раскраску графа
  for(int i = 1; i <= N; ++i)
    cout << color[i] << " ";
  cout << endl;

  return 0;
}
