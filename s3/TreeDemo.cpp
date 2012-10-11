// TreeDemo.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"

#include <iostream>
#include <assert.h>

using namespace std;

// Вершина (узел) дерева
template <typename T> // T - тип значения для дерева
struct Node { // struct - все поля и методы по-умолчанию public
  T value; // Значение в узле дерева
  int count; // Количество элементов с таким значением
  Node* left, *right; // Ссылки на левое и правое поддерево
  // Конструктор
  Node(T value) {
    left = right = NULL;
    this->value = value;
    count = 1; // Количество включая данный узел
  };
};

// Дерево
template <typename T> // T - тип значения для дерева
class Tree { // class - все поля и методы по-умолчанию private
  Node<T>* root; // Вершина дерева
public:
  Tree() {
    root = NULL;
  }
  // Добавить значение
  void add(T value) {
    // Создаём новый элемент
    Node<T>* el = new Node<T>(value);
    // Если нет ни одного элемента, то этот элемент корневой
    if(root == NULL) {
      root = el;
      return;
    };
    // Ищем, к какому узлу нам подвесить наш новый элемент
    Node<T>* cur = root; // Указатель при поиске
    while(cur != NULL) {
      // Исследуем, можем ли мы подвесить el к cur
      if(value < cur->value) { // Идём влево
        if(cur->left == NULL) {
          cur->left = el; // Подвешиваем новый элемент слева
          return;
        }
        cur = cur->left; // Спускаемся дальше влево
      };
      if(value > cur->value) { // Идём вправо
        if(cur->right == NULL) {
          cur->right = el; // Подвешиваем новый элемент справа
          return;
        }
        cur = cur->right; // Спускаемся дальше вправо
      };
      if(value == cur->value) {
        cur->count++;
        delete el; // Очищаем память
        return;
      };
    };
  };
  // Найти значение
  bool find(T value) {
    Node<T>* cur = root; // Указатель, которым мы ищем
    while(cur != NULL) {
      if(cur->value == value)
        return true; // Нашли элемент!
      if(value > cur->value) // Если то что мы ищем больше текущего => идём вправо
        cur = cur->right;
      else if(value < cur->value)
        cur = cur->left;
    }
    // Если до сих пор не нашли, значит его нет ;)
    return false;
  }
  // Рекурсивный поиск с возращением количества таких элементов
  int count(T value) {
    return countRec(value, root);
  }
  int countRec(T value, Node<T>* cur) {
    if(cur == NULL) return 0;
    if(cur->value == value) return cur->count;
    return countRec(value, (value > cur->value) ? cur->right : cur->left);
  }
};



int main() {
  Tree <int> t;

  assert(!t.find(5));
  t.add(5);
  assert(t.count(5) == 1);

  t.add(5);
  assert(t.count(5) == 2);

  int g;
  int h;
  cout << "If Add, write '1' or Find, write '2'?" << endl;

  do {
    cin >> g;

    if(g == 1) {
      cin >> h;
      t.add(h);
    }

    if(g == 2) {
      cin >> h;
      t.find(h);
      if(t.find(h))
        cout << "We found this number" << endl;
      else
        cout << "not.";
    }

  } while(g != 0);

  return 0;
}

