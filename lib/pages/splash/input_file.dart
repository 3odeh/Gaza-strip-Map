import 'dart:io';

import '../../graph/vertex_model.dart';
import '../../model/city_model.dart';
import '../map/gaza_map.dart';

class InputFile {
  static const String _MAP_FILE_PATH = 'lib\\data\\map.txt';

  static Future<List<VertexModel<CityModel>?>?> readMapFile({
    required Function(String error) onError,
    required Function(String error) ignoreLine,
  }) async {
    try {
      File mapFile = File(_MAP_FILE_PATH);
      List<String> lines = await mapFile.readAsLines();
      List<String> splitFirstLine = lines[0].split(' ');
      int v = int.parse(splitFirstLine[0]);
      int a = int.parse(splitFirstLine[1]);

      List<VertexModel<CityModel>?> table =
          List.generate(v + 1, (index) => null);
      // v + 1 to ignore first index

      int index = 1;
      int vertextCount = 1;
      bool isIgnoreLines = false;
      for (; index < table.length; index++) {
        try {
          table[index] = VertexModel(
              info: CityModel.cityModelFromString(lines[index]),
              currentVertex: index);
          vertextCount++;
        } catch (e) {
          isIgnoreLines = true;
          ignoreLine(e.toString());
        }
      }
      if (isIgnoreLines) {
        List<VertexModel<CityModel>?> tmpTable =
            List.generate(vertextCount, (index) => null);

        for (var i = 1, j = 1; i < table.length; i++) {
          if (table[i] != null) {
            tmpTable[j] = table[i];
            tmpTable[j]!.currentVertex = j;
            j++;
          }
        }
        table = tmpTable;
      }

      // i to loop a time and the index for lines index
      for (int i = 0; i < a; i++, index++) {
        _addAdjacent(table, lines[index]);
      }

      return table;
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }

  static void _addAdjacent(List<VertexModel<CityModel>?> table, String line) {
    List<String> tmpList = line.split(' ');

    // This to get vertex
    VertexModel<CityModel>? v1;

    for (var element in table) {
      if (element != null && element.info.name == tmpList[0]) {
        v1 = element;
        break;
      }
    }
    if (v1 == null) {
      return;
    }
    VertexModel<CityModel>? v2;
    for (var element in table) {
      if (element != null && element.info.name == tmpList[1]) {
        v2 = element;
        break;
      }
    }

    if (v2 == null) {
      return;
    }

    double distance = GazaMap.calculateDistance(
      latitude1: v1.info.latitude,
      longitude1: v1.info.longitude,
      latitude2: v2.info.latitude,
      longitude2: v2.info.longitude,
    );
    v1.adjacents.addFirst((v2.currentVertex, distance));
    v2.adjacents.addFirst((v1.currentVertex, distance));
  }
}
