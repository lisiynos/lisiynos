// Сумма, цикл, вверх
int sum(int a, int b) {
  int res = 0;
  for(a += N - 1, b += N - 1; a <= b; a >>= 1, b >>= 1) {
    if(a % 2 == 1) {
      res += tree[a];
      a++;
    }
    if(b % 2 == 0) {
      res += tree[b];
      b--;
    }
  }
  return res;
}
