import 'linked_list.dart';

class MyQueue<T> {
  int size = 0;

  MyLinkedList<T>? linkedList;
  List<T?>? array;
  int front = 0;
  int rear = 0;

  MyQueue() {
    linkedList = MyLinkedList();
  }

  MyQueue.withSize(int size) {
    array = List<T?>.filled(size + 2, null);
    rear = size + 1;
  }

  bool get isEmpty => size == 0;

  int get queueSize => size;

  T? dequeue() {
    if (isEmpty) return null;
    size--;

    if (linkedList != null) {
      T? o = linkedList!.getFirst();
      linkedList!.removeFirst();
      return o;
    } else {
      rear = _getNext(rear);
      return array![rear];
    }
  }

  void enqueue(T o) {
    if (!isFull()) {
      size++;
      if (linkedList != null) {
        linkedList!.addLast(o);
      } else {
        array![front] = o;
        front = _getNext(front);
      }
    } else {
      print("The queue is full");
    }
  }

  void clear() {
    size = 0;
    if (linkedList != null) {
      linkedList!.clear();
    } else {
      front = _getNext(rear);
    }
  }

  void printQueue() {
    for (int i = 0; i < size; i++) {
      T? o = dequeue();
      print(o);
      enqueue(o!);
    }
  }

  int _getNext(int c) {
    if (c == (array!.length - 1)) return 0;
    return c + 1;
  }

  bool isFull() {
    if (linkedList != null) return false;
    return (rear == _getNext(front));
  }
}
