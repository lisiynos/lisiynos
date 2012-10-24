#include <iostream>
#include <assert.h>

using namespace std;

// Определение класса Стек
// Шаблон с двумя параметрами:
//   T - тип элемента (например: int, char, char*)
//   size - размер стека (целое число)
template <typename T, int size>
class Stack {
  T data[size]; // Данные стека
  int count; // Количество элементов в стеке
  // count указывает на ячейку после последнего элемента в стеке
  // Например, если count = 1, то последний элемент это data[0]
public:
  // Конструктор
  Stack() {
    count = 0;
  };
  // Стек пуст?
  bool isEmpty() {
    return count <= 0;
  };
  // Стек полон?
  bool isFull() {
    return count >= size;
  };
  // Добавить на вершину стека
  void push(T value) {
    assert(!isFull()); // Можно добавить только если стек ещё не полон
    data[count++] = value; // Записываем значение в массив и сдвигаем счётчик вправо
  }
  // Снять с вершины стека
  T pop() {
    assert(!isEmpty()); // Можно снять только если стек не пуст
    return data[--count]; // Уменьшаем счётчик (сдвигаем влево) и возвращаем значение

    ++(--count++)--
  }
};

// Основная программа - тестирование стека
int main() {
  Stack<int, 5> s; // Создаём пример стека
  assert(s.isEmpty()); // Сейчас стек должен быть пустым
  s.push(5); // Добавляем один элемент
  assert(!s.isEmpty());
  assert(s.pop() == 5);
  assert(s.isEmpty());
  assert(!s.isFull());
  s.push(1);
  s.push(2);
  s.push(3);
  s.push(4);
  assert(!s.isFull()); // Стек ещё не полон после добавления четвёртого элемента
  s.push(5);
  assert(s.isFull());

  Stack<char, 2> cs; // Заводим другой пример стека - с символами в качестве элементов
  cs.push('a');

  return 0;
}