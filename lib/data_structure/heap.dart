class XHeap<T extends Comparable> {
  late List<T?> _array;
  int _heapSize = 0;

  XHeap(int size) {
    _array = List.generate(size + 1, (index) => null);
  }

  int size() => _heapSize;

  void insert(T data) {
    if (!isFull()) {
      _array[_heapSize + 1] = data;
      _heapSize++;
      int i = _getParent(_heapSize);
      int c = _heapSize;
      while (
          i > 0 && (_array[i] != null && _array[i]!.compareTo(_array[c]) > 0)) {
        T? tmp = _array[c];
        _array[c] = _array[i];
        _array[i] = tmp;
        c = i;
        i = _getParent(c);
      }
    } else {
      print("Full");
    }
  }

  T? removeMin() {
    if (isEmpty()) {
      return null;
    } else {
      T? min = _array[1];
      int p = 1;
      int c = _getMinChild(1);

      while (c > 0) {
        T? tmp = _array[c];
        _array[c] = _array[p];
        _array[p] = tmp;

        p = c;
        c = _getMinChild(c);
      }

      T? tmp = _array[_heapSize];
      _array[_heapSize] = _array[p];
      _array[p] = tmp;

      _heapSize--;
      return min;
    }
  }

  bool isEmpty() {
    return _heapSize == 0;
  }

  bool isFull() {
    return _heapSize == _array.length - 1;
  }

  int _getParent(int i) {
    if (i <= _heapSize) return i ~/ 2;
    return -1;
  }

  int _getLeftChild(int i) {
    if (i * 2 <= _heapSize) return i * 2;
    return -1;
  }

  int _getRightChild(int i) {
    if (i * 2 + 1 <= _heapSize) return i * 2 + 1;
    return -1;
  }

  int _getMinChild(int p) {
    int l = _getLeftChild(p);
    int r = _getRightChild(p);
    if (r < 0) return l;
    if (l < 0) return r;
    if (_array[r] == null || _array[r]!.compareTo(_array[l]) < 0) l = r;

    return l;
  }

  void printHeap() {
    for (int i = 1; i <= _heapSize; i++) {
      print(_array[i]);
    }
  }
}
