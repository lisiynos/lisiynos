//#include <cmath>
#include "testlib.h"

int main( int argc, char *argv[] )
{
  setName("Чекер для задачи A+B");
  registerTestlibCmd(argc, argv);
  int a = inf.readInt(), b = inf.readInt(); // Чтение исходных данных
  int pa = ouf.readInt(); // Ответ участника
  int ja = ans.readInt(); // Ответ жюри
  if (ja != pa)
    quitf(_wa, "%d + %d = %d, а выведено %d", a, b, ja, pa );
  quitf(_ok, "ans = %d, a=%d,b=%d", pa, a, b);
}

