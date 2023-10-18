// ��������� ����� � 2 �����
#include <iostream>
#include <assert.h>
#include <stdio.h>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <stdlib.h>

using namespace std;

// ������������ ���������� ������
const int maxN = 101;

int N = 3;

// g[i] - ������ ������ ������� � ������
vector<int> g[maxN];

// color[i] - ���� ������� i
int color[maxN];

// Depth First Search
int dfs(int n, int c) {
  assert(c == 1 || c == 2);
  // TODO: ���������� ���� ������
  assert(color[n] == 0); // ������� �� ���������
  // ������ � ������ ����
  color[n] = c;
  // ���� ������� ����� � ������ ����
  int c2 = 3 - c; // ����� 1 � 2, ������� ������ ���� 3-�
  assert(c2 != c); // ������ ���� ������ ����
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

// ��� ������� ����� ������������
#define DEBUG

int main() {
  // ���������� �����
#ifdef DEBUG

#endif
  freopen("task.in", "r", stdin);
  //freopen("task.out","w",stdout);
  // �������� �����������
  //assert(2*2 == 4);
  /*
   ������ � set
   set<int> s;
   s.insert(2);
   s.insert(3);
   s.insert(2);

  // ���������
   cout << "Size: " << s.size() << endl;
   for(set<int>::iterator i = s.begin(); i != s.end(); i++){
       cout << *i << endl;
   }

   // ������ � map
   map<int,string> m;
   m[2] = "222";
   for(map<int,string>::iterator i =
       m.begin(); i != m.end(); i++){
       cout << i->first << " " << i->second << endl;
   } */
  // ������� + ����
  int m;
  cin >> N >> m;
  // ��������� ����
  for(int i = 0; i < m; ++i) {
    int a, b;
    cin >> a >> b;
    g[a].push_back(b);
    g[b].push_back(a);
  }
  // ����� ��������� ���������
  for(int i = 1; i <= N; ++i)
    if(!color[i]) // �� ��������� �������
      if(!dfs(i, 1)) { // ������ � 1-�� ����
        // �� ������� ���������
        cout << -1 << endl;
        return 0;
      }

  // ������� ��������� �����
  for(int i = 1; i <= N; ++i)
    cout << color[i] << " ";
  cout << endl;

  return 0;
}
