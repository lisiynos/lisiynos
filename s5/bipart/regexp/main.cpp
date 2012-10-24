// C++ 11
#include <iostream>
#include <regex>

using namespace std;

int main() {
  string str = "Hello world";
  std::tr1::regex rx("ello");
  regex_match(str.begin(), str.end(), rx)
  cout << "Hello world!" << endl;
  return 0;
}
