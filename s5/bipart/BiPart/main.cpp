// ������������ �������������
#include <iostream>
#include <assert.h>
#include <stdio.h>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <stdlib.h>

using namespace std;

// ������������ ���������� ������ � ����
const int maxN = 101;

// и��� �� ������ ���� �� ������
vector<int> g[maxN];

// ������ ������ ����, ������ � ���������� ����
int m, n, k;

// -1 ���� ��� ����� � ����� ������� ��
// A ���� ���� �����
int back[maxN];

int main() {
  freopen("bipart.in", "r", stdin);
  //freopen("bipart.out","w",stdout);
  // m - ������ � A
  // n - ������ � B
  // k - ���� �� A � B
  cin >> m >> n >> k;

  // ��������� ������ back -1
  fill(back, back + maxN, -1);

  // �������� dfs...
  // ...��������...

  return 0;
}
