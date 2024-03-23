import 'package:project3_flutter/data_structure/linked_list.dart';

import '../util/constant_number.dart';

class VertexModel<T> implements Comparable<VertexModel?> {
  // This to save data of vertex
  final T _info;

  // This if we check adjacents or not
  // bool _known;

  num _distance;

  // Current vertex index
  int _currentVertex;

  // Previous vertex index
  int _preVertex;

  // Index : The index of adjacent in table
  // Cost : (unweighted = 1) , (weighted = value)
  MyLinkedList<(int index, num cost)> _adjacents;

  VertexModel({
    required T info,
    bool known = false,
    num distance = ConstantNumber.MAX_INTEGET,
    int previousVertex = 0,
    required int currentVertex,
    MyLinkedList<(int index, num cost)>? adjacents,
  })  : _info = info,
        //   _known = known,
        _distance = distance,
        _preVertex = previousVertex,
        _currentVertex = currentVertex,
        _adjacents = adjacents ?? MyLinkedList();

  // Getter for info
  T get info => _info;

  // Getter and setter for known
  // bool get known => _known;
  // set known(bool isKnown) => _known = isKnown;

  // Getter and setter for previousVertex
  int get previousVertex => _preVertex;
  set previousVertex(int previousVertex) => _preVertex = previousVertex;

  // Getter and setter for currentVertex
  int get currentVertex => _currentVertex;
  set currentVertex(int currentVertex) => _currentVertex = currentVertex;

  // Getter and setter for distance
  num get distance => _distance;
  set distance(num distance) => _distance = distance;

  // Getter and setter for adjacents
  MyLinkedList<(int index, num cost)> get adjacents => _adjacents;
  set adjacents(MyLinkedList<(int index, num cost)> newAdjacents) =>
      _adjacents = newAdjacents;

  void resetVertix() {
    // known = false;
    distance = ConstantNumber.MAX_INTEGET;
    previousVertex = 0;
  }

  @override
  String toString() {
    return 'VertexModel ['
        ' info: $info,'
        // ' known: $known,'
        ' distance: $distance,'
        ' previousVertex: $previousVertex,'
        ' currentVertex: $currentVertex,'
        ' adjacents: $adjacents'
        ' ]';
  }

  @override
  int compareTo(VertexModel? other) {
    return _distance.compareTo(other?.distance ?? 0);
  }
}
