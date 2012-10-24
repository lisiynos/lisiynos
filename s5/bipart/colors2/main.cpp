#include<vector>
#include<map>
#include<set>
#include<assert.h>
#include<iostream>
#include<cstdio>

using namespace std;

const int maxn = 101;
int n = 3;

vector<int>g[maxn];
int color[maxn];

bool dfs(int n, int c) {
  int v;
  color[n] = c;
  int ac = 3 - c;
  for (int i = 0; i < g[n].size(); i++) {
    v = g[n][i];
    if (color[v] == ac) {
      continue;
    }
    if (color[v] == c) {
      return false;
    }
    if (!dfs(v, ac)) {
      return false;
    }
  }
  return true;
}

int main() {
  int n, m, a, b;
  freopen("paint.in", "r", stdin);
  freopen("paint.out", "w", stdout);
  cin >> n >> m;
  for (int i = 0; i < n; i++) {
    cin >> a >> b;
    g[a - 1].push_back(b - 1);
    g[b - 1].push_back(a - 1);
  }

  for (int i = 0; i < n; i++)
    color[i] = 0;

  bool ress = true;
  for (int i = 0; i < n; i++) {
    if (!color[i]) {
      ress &= dfs(i, 1);
    }
  }
  if (ress) {
    for (int i = 0; i < n; i++) {
      cout << color[i] << ' ';
    }
  } else {
    cout << "Lol! You died!!!";
  }
  return 0;
}
