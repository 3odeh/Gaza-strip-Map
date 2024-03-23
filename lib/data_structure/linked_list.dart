import 'linked_node.dart';

class MyLinkedList<T> {
  Node<T>? _first;
  Node<T>? _last;
  int _count = 0;

  MyLinkedList();

  bool isEmpty() {
    return _count == 0;
  }

  T? getFirst() {
    return _count != 0 ? _first!.element : null;
  }

  T? getLast() {
    return _count != 0 ? _last!.element : null;
  }

  void addFirst(T o) {
    if (_count == 0) {
      _first = _last = Node<T>(o);
    } else {
      Node<T> tmp = Node<T>(o);
      tmp.next = _first;
      _first = tmp;
    }
    _count++;
  }

  void addLast(T o) {
    if (_count == 0) {
      _first = _last = Node<T>(o);
    } else {
      Node<T> newN = Node<T>(o);
      _last!.next = newN;
      _last = _last!.next;
    }
    _count++;
  }

  void add(T o, int index) {
    if (index == 0) {
      addFirst(o);
    } else if (index >= _count) {
      addLast(o);
    } else {
      Node current = _first!;
      Node node = Node(o);
      for (int i = 0; i < index - 1; i++) {
        current = current.next!;
      }
      node.next = current.next;
      current.next = node;
      _count++;
    }
  }

  int size() {
    return _count;
  }

  void clear() {
    _first = _last = null;
  }

  bool removeFirst() {
    if (_count == 0) {
      return false;
    } else {
      if (_count == 1) {
        _last = _first = null;
      } else {
        _first = _first!.next;
      }
      _count--;
      return true;
    }
  }

  bool removeLast() {
    if (_count == 0) {
      return false;
    } else {
      if (_count == 1) {
        _last = _first = null;
      } else {
        Node<T> current = _first!;
        for (int i = 0; i < _count - 2; i++) {
          current = current.next!;
        }
        _last = current;
        _last!.next = null;
      }
      _count--;
      return true;
    }
  }

  bool remove(int index) {
    if (index < 0 || index >= _count) {
      return false;
    } else if (index == 0) {
      return removeFirst();
    } else if (index == _count - 1) {
      return removeLast();
    } else {
      Node current = _first!;
      for (int i = 0; i < index - 1; i++) {
        current = current.next!;
      }
      current.next = current.next!.next;
      _count--;
      return true;
    }
  }

  bool removeElement(T? o) {
    if (_count == 0) {
      return false;
    } else {
      if (_first!.element == o) {
        return removeFirst();
      } else {
        Node previous = _first!;
        Node current = _first!.next!;
        while (current.element != o) {
          previous = current;
          current = current.next!;
        }
        previous.next = current.next;
        _count--;
        return true;
      }
    }
  }

  bool search(T? o) {
    Node? current = _first;
    while (current != null) {
      if (current.element == o) {
        return true;
      }
      current = current.next;
    }
    return false;
  }

  void printList() {
    Node? current = _first;
    while (current != null) {
      print("${current.element}, ");
      current = current.next;
    }
    print("");
  }

  void allNodeLoop(void Function(T node) executeFuction) {
    Node<T>? current = _first;
    while (current != null) {
      executeFuction(current.element);
      current = current.next;
    }
  }

  T? firstWhere(bool Function(T) condition) {
    Node<T>? current = _first;
    while (current != null) {
      if (condition(current.element)) {
        return current.element;
      }
      current = current.next;
    }
    return null;
  }
}
