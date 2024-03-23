import '../data_structure/heap.dart';
import 'vertex_model.dart';

class ShortestPath<T> {
  final List<VertexModel<T>?> _table;
  // ignore: prefer_final_fields
  int _start = 0;

  ShortestPath({
    required List<VertexModel<T>?> table,
  }) : _table = table;

  void _resetTable() {
    for (var i = 1; i < _table.length; i++) {
      _table[i]!.resetVertix();
    }
  }

  void printTable() {
    for (var i = 0; i < _table.length; i++) {
      print('$i ${_table[i]}');
    }
  }

  (num, List<(int, num)>) dijkstraUpdate({
    required int start,
    required int destination,
  }) {
    // When the start index is the same previos start index
    // we dont need to calculate the shortest path cus the result will be the same
    if (_start == start) {
      return _getPath(destination);
    }
    _start == start;
    _resetTable();
    _table[start]!.distance = 0;

    // This heap to save all unknown vertex that update the distance values
    XHeap<VertexModel> unknownVertex = XHeap<VertexModel>(_table.length);
    unknownVertex.insert(_table[start]!);

    while (true) {
      // Get smallest unknown distance vertex
      VertexModel? smallestUDV = unknownVertex.removeMin();
      if (smallestUDV == null) {
        break;
      }
      //smallestUDV.known = true;

      smallestUDV.adjacents.allNodeLoop((element) {
        // index : adj.$1
        // cost : adj.$2
        //  if (!_table[adj.$1]!.known) {
        if (smallestUDV.distance + element.$2 < _table[element.$1]!.distance) {
          _table[element.$1]!.distance = smallestUDV.distance + element.$2;
          _table[element.$1]!.previousVertex = smallestUDV.currentVertex;
          unknownVertex.insert(_table[element.$1]!);
        }
        //  }
      });
    }
    return _getPath(destination);
  }

  // This method to get path from table
  (num, List<(int, num)>) _getPath(int destination) {
    List<(int, num)> result = [];
    num totalDistance = 0;

    for (int index = destination; index > 0;) {
      int preIndex = _table[index]!.previousVertex;
      if (preIndex == 0) {
        result.add((index, 0));
      } else {
        var adjacent = _table[preIndex]!
            .adjacents
            .firstWhere((element) => element.$1 == index);
        result.add(adjacent!);
        totalDistance += adjacent.$2;
      }

      index = preIndex;
    }
    return (totalDistance, result);
  }

  // (num, List<(int, num)>) dijkstra({
  //   required int start,
  //   required int destination,
  // }) {
  //   // When the start index is the same previos start index
  //   // we dont need to calculate the shortest path cus the result will be the same
  //   if (_start == start) {
  //     return _getPath(destination);
  //   }
  //   _start == start;
  //   _resetTable();
  //   _table[start]!.distance = 0;
  //   while (true) {
  //     // Get smallest unknown distance vertex
  //     VertexModel? smallestUDV = getSmallestUnknownDistenceVertex();

  //     if (smallestUDV == null) {
  //       break;
  //     }

  //     smallestUDV.known = true;
  //     for ((int index, num cost) adj in smallestUDV.adjacents) {
  //       // index : adj.$1
  //       // cost : adj.$2
  //       if (!_table[adj.$1]!.known) {
  //         if (smallestUDV.distance + adj.$2 < _table[adj.$1]!.distance) {
  //           _table[adj.$1]!.distance = smallestUDV.distance + adj.$2;
  //           _table[adj.$1]!.previousVertex = smallestUDV.currentVertex;
  //         }
  //       }
  //     }
  //   }
  //   return _getPath(destination);
  // }

  // VertexModel? getSmallestUnknownDistenceVertex() {
  //   num smallestNumber = ConstantNumber.MAX_INTEGET;
  //   int smallestIndex = -1;
  //   for (int i = 1; i < _table.length; i++) {
  //     if (!_table[i]!.known && _table[i]!.distance < smallestNumber) {
  //       smallestNumber = _table[i]!.distance;
  //       smallestIndex = i;
  //     }
  //   }
  //   return (smallestIndex < 1) ? null : _table[smallestIndex];
  // }
}
