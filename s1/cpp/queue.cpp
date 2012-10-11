#include <iostream>
#include <assert.h>

using namespace std;

// Определение класса Очередь
// Шаблон с двумя параметрами:
//   T - тип элемента (например: int, char, char*)
//   size - размер стека (целое число)
template <typename T, int size>
class Queue {
  T data[size]; // Данные очереди
  int head; // Голова очереди (первый элемент)
  int tail; // Хвост очереди (последний элемент)
public:
  // Конструктор
  Queue() {
    head = -1;
    tail = 0;
  };
  // Очередь пуста?
  bool isEmpty() {
    return head < tail;
  };
  // Очередь полна?
  bool isFull() {
    return (head - tail + 1) >= size;
  };
  // Добавить в начало очереди
  void put(T value) {
    assert(!isFull()); // Можно добавить только если очередь не полна
    data[++head] = value; // Сдвигаем голову вправо и записываем значение
  }
  // Взять из конца очереди
  T get() {
    assert(!isEmpty()); // Можно снять только если очередь не полна
    return data[tail++]; // Забираем значение из хвоста и двигаем хвост вправо
  }
};

// Основная программа - тестирование стека
int main() {
  Queue<int, 5> s; // Создаём пример стека
  assert(s.isEmpty()); // Сейчас очередь должна быть пуста
  s.put(5); // Добавляем один элемент
  assert(!s.isEmpty());
  assert(s.get() == 5);
  assert(s.isEmpty());
  assert(!s.isFull());
  s.put(1);
  s.put(2);
  s.put(3);
  s.put(4);
  assert(!s.isFull());
  s.put(5);
  assert(s.isFull());

  return 0;
}