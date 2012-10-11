#include <iostream>
#include <fstream>
#include <vector>
#include <cstring>
#include <cstdio>
#include <algorithm>

const int base = 1000 * 1000 * 1000;
using namespace std;

typedef vector<int> Big;



void print(Big a) {
  FILE* pFile;
  pFile = fopen ("sum.out", "w");
  fprintf (pFile, "%d", a.empty() ? 0 : a.back());
  for (int i = (int)a.size() - 2; i >= 0; --i)
    fprintf (pFile, "%09d", a[i]);
  fclose (pFile);
  return;
}

Big read(char* s) {
  Big a;
  for (int i = (int)strlen(s); i > 0; i -= 9) {
    s[i] = 0;
    a.push_back (atoi (i >= 9 ? s + i - 9 : s));
  }
  return a;
}

void DelZero(Big a) {
  while (a.size() > 1 && a.back() == 0)
    a.pop_back();
}

Big add(Big a, Big b) {
  Big c(max(a.size(), b.size()
           ));
  int carry = 0;
  for (size_t i = 0; i < max(c.size(), b.size()) || carry; ++i) {
    if (i == c.size())
      c.push_back (0);
    c[i] += carry + (i < b.size() ? b[i] : 0);
    carry = a[i] >= base;
    if (carry)  c[i] -= base;
  }
  return c;
}

int main() {
  /*  FILE * pFile;
    pFile = fopen ("sum .out","w");*/
  fstream in;
  in.open("sum.in", fstream::in);
  char a[3000], b[3000];
  in >> a >> b;
  Big a1 = read(a), b1 = read(b);

  Big c = add(a1, b1);
  print(c);
  return 0;
}
