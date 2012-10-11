#include <iostream>
#include <fstream>
#include <iomanip>
#include <vector>

using namespace std;

int main() {
  fstream in;
  in.open("toany.in", fstream::in);
  long long int n;
  int base;
  fstream out;
  out.open("toany.out", fstream::out);
  while(!in.eof()) {
    vector<char> bb;
    in >> n >> base;
    int cur;
    while(n != 0) {
      cur = n / base;
      if(cur > 9) bb.push_back(char(cur + 55));
      else bb.push_back(char(cur + 48));
      n -= cur * base;
    }
    for(int i = 0; i < bb.size(); i++)
      out << bb[i];
    out << endl;
  }
  return 0;
}