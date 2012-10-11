#include <stdio.h>
#include <iostream>

using namespace std;

int A[1000000];

// Случайное целое число в заданном диапазоне
int rand(int low, int high) {
  return rand() % (high - low + 1) + low;
}

// Поменять местами 2 элемента
void swap(int i, int j) {
  int temp = A[i];
  A[i] = A[j];
  A[j] = temp;
}

// Быстрая сортировка
void qsort(int left, int right) {
  if(left >= right) return;
  int l = left;
  int r = right;
  // Разделяющий элемент - может быть любым, но выбор случайного элемента устойчив к худшим случаям
  int m = A[rand(left, right)];
  do {
    while(A[l] < m) l++;
    while(A[r] > m) r--;
    if(l <= r) {
      swap(l, r);
      l++;
      r--;
    }
  } while (l <= r);
  qsort(left, r);
  qsort(l, right);
}

int main() {
  freopen("qsort.in", "r", stdin);
  freopen("qsort.out", "w", stdout);
  // Ввод исходных данных
  int N;
  cin >> N;
  for(int i = 0; i < N; i++)
    cin >> A[i];
  // Сортировка
  qsort(0, N - 1);
  // Вывод отсортированного массива
  for(int i = 0; i < N; i++)
    cout << A[i] << " ";

  return 0;
}

