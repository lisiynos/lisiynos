// KeyValueArray.cpp: определяет точку входа для консольного приложения.
#include "stdafx.h"
#include <assert.h>

using namespace std;

// Пара ключ-значение
struct key_value_pair {
  string key; // Ключ
  string value; // Значение
  key_value_pair* left, *right; // Левое и правое поддерево
  <<< <<< < HEAD
  key_value_pair(string key, string value) : key(key), value(value) {
    left = NULL;
    right = NULL;
  }
};

struct dictionary;

struct my_iterator {
  dictionary* d;
  string key;
  void operator =(string value);
  operator string();
};

// Словарь - массив "ключ-значение"
struct dictionary {
  key_value_pair* root; // Корень дерева
  dictionary() {
    root = NULL;
  };
  void add(string key, string value) {
    key_value_pair* n = new key_value_pair(key, value);
    if(root == NULL) {
      root = n;
      return;
      == == == =
        key_value_pair(string key, string value) : key(key), value(value), left(NULL), right(NULL) {
      }
    };

    // Словарь
    struct dictionary {
      key_value_pair* root; // Корень дерева
      dictionary() : root(NULL) {
      };
      // Добавление нового узла
      key_value_pair* add(string key, string value) {
        key_value_pair* n = new key_value_pair(key, value);
        if(root == NULL) {
          root = n;
          return n;
          >>> >>> > 53fdeb2efbc58c2d155d2403ac1f305307a301b2
        }
        // Ищем место под новый узел
        key_value_pair* cur = root;
        while(cur != NULL) {
          if(key > cur->key) {
            if(cur->right == NULL) {
              cur->right = n;
              <<< <<< < HEAD
              return;
              == == == =
                return n;
              >>> >>> > 53fdeb2efbc58c2d155d2403ac1f305307a301b2
            }
            cur = cur->right;
          }
          if(key < cur->key) {
            if(cur->left == NULL) {
              cur->left = n;
              <<< <<< < HEAD
              return;
              == == == =
                return n;
              >>> >>> > 53fdeb2efbc58c2d155d2403ac1f305307a301b2
            }
            cur = cur->left;
          }
          if(key == cur->key) {
            cur->value = value;
            delete n;
            <<< <<< < HEAD
          }
        }
      };
      // Поиск в дереве поиска
      string find(string key) {
        == == == =
          return cur;
      }
    }
    assert(false);
    return NULL;
  };
  // Поиск в дереве поиска
  string& find(string key) {
    >>> >>> > 53fdeb2efbc58c2d155d2403ac1f305307a301b2
    key_value_pair* cur = root;
    while(cur != NULL) {
      if(key < cur->key)
        cur = cur->left;
      else if(key > cur->key)
        cur = cur->right;
      else if(key == cur->key)
        return cur->value;
    };
    <<< <<< < HEAD
    return string("Not found!");
  };

  string& operator [](string key) {
    add(key, "Not found!");
    == == == =
      // Создаем новый узел
      return add(key, "Not found!")->value;
  };

  string& operator [](string key) {
    >>> >>> > 53fdeb2efbc58c2d155d2403ac1f305307a301b2
    return find(key);
  }
};

<<< <<< < HEAD


int _tmain(int argc, _TCHAR* argv[]) {
  dictionary d;
  //d.add("hello","HI!");
  d["hello"] = "HI!";
  cout << d.find("hello") << endl;

  cout << d["hello"] << endl;
  == == == =
  int main() {
    dictionary d;
    d.add("hello", "HI!");
    cout << d.find("hello") << endl;
    d["hello2"] = "HI2!";
    cout << d["hello"] << endl;
    cout << d["hello2"] << endl;

    >>> >>> > 53fdeb2efbc58c2d155d2403ac1f305307a301b2
    return 0;
  }

