class Node<T> {
  T _element;
  Node<T>? _next;

  Node(this._element);

  T get element => _element;

  set element(T value) {
    _element = value;
  }

  Node<T>? get next => _next;

  set next(Node<T>? value) {
    _next = value;
  }
}
