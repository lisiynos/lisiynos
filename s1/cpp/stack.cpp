#include <iostream>
#include <assert.h>

using namespace std;

// ����������� ������ ����
// ������ � ����� �����������:
//   T - ��� �������� (��������: int, char, char*)
//   size - ������ ����� (����� �����)
template <typename T, int size>
class Stack {
  T data[size]; // ������ �����
  int count; // ���������� ��������� � �����
  // count ��������� �� ������ ����� ���������� �������� � �����
  // ��������, ���� count = 1, �� ��������� ������� ��� data[0]
public:
  // �����������
  Stack() {
    count = 0;
  };
  // ���� ����?
  bool isEmpty() {
    return count <= 0;
  };
  // ���� �����?
  bool isFull() {
    return count >= size;
  };
  // �������� �� ������� �����
  void push(T value) {
    assert(!isFull()); // ����� �������� ������ ���� ���� ��� �� �����
    data[count++] = value; // ���������� �������� � ������ � �������� ������� ������
  }
  // ����� � ������� �����
  T pop() {
    assert(!isEmpty()); // ����� ����� ������ ���� ���� �� ����
    return data[--count]; // ��������� ������� (�������� �����) � ���������� ��������

    ++(--count++)--
  }
};

// �������� ��������� - ������������ �����
int main() {
  Stack<int, 5> s; // ������ ������ �����
  assert(s.isEmpty()); // ������ ���� ������ ���� ������
  s.push(5); // ��������� ���� �������
  assert(!s.isEmpty());
  assert(s.pop() == 5);
  assert(s.isEmpty());
  assert(!s.isFull());
  s.push(1);
  s.push(2);
  s.push(3);
  s.push(4);
  assert(!s.isFull()); // ���� ��� �� ����� ����� ���������� ��������� ��������
  s.push(5);
  assert(s.isFull());

  Stack<char, 2> cs; // ������� ������ ������ ����� - � ��������� � �������� ���������
  cs.push('a');

  return 0;
}