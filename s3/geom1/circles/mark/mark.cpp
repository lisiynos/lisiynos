#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <iomanip>

const long double pi = 3.1415926535897932384626433832795;

using namespace std;

int main() {
  fstream in;
  in.open("circles.in", fstream::in);
  int x, y, r;
  in >> x >> y >> r;
  long double a = sqrt(pi * r * r) / 2;
  fstream out;
  out.open("circles.out", fstream::out);
  out << setiosflags(ios::fixed) << setprecision(6);
  out << x - a << ' ' << y - a << endl;
  out << x - a << ' ' << y + a << endl;
  out << x + a << ' ' << y + a << endl;
  out << x + a << ' ' << y - a << endl;
  return 0;
}