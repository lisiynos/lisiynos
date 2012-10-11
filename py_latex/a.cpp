#include <cstdlib>
#include <iostream>
#include <cmath>
#include <cstdio>
#include <iomanip>

using namespace std;

int main() {
  freopen("sqrteq.in", "r", stdin);
  freopen("sqrteq.out", "w", stdout);
  long double a, b, c, D, x1, x2;
  cin >> a >> b >> c;
  cout << a << " " << b << " " << c << endl;
  if (abs(a) < 0.0000001) {
    if (abs(b) < 0.0000001) {
      if (abs(c) < 0.0000001) {
        cout << -1;
      } else {
        cout << 0;
      }
    } else {
      x1 = -c / b;
      cout << 1 << ' ' << setiosflags(ios::fixed) << setprecision(15) << x1;
    }
  } else {
    D = b * b - 4 * a * c;
    if (abs(D) < 0.0000001) {
      cout << 1 << ' ' << setiosflags(ios::fixed) << setprecision(15) << -b / (2 * a);
    } else {
      if (D < 0) {
        cout << 0;
      } else {
        D = sqrt(D);
        x1 = (-b + D) / (2 * a);
        x2 = (-b - D) / (2 * a);
        cout << 2 << ' ' << setiosflags(ios::fixed) << setprecision(15) << min(x1, x2) << ' ' << max(x1, x2);
      }
    }
  }
}