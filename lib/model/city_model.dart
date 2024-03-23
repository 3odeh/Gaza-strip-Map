import 'package:project3_flutter/pages/map/gaza_map.dart';

class CityModel {
  final String _name;
  final double _latitude;
  final double _longitude;

  CityModel({
    required String name,
    required double latitude,
    required double longitude,
  })  : _name = name,
        _latitude = latitude,
        _longitude = longitude;

  // Named constructor for create City object from line
  CityModel.fromString(String line)
      : _name = line.split(' ')[0],
        _latitude = double.parse(line.split(' ')[1]),
        _longitude = double.parse(line.split(' ')[2]);

  static CityModel cityModelFromString(String line) {
    var name = line.split(' ')[0];

    var latitude = double.parse(line.split(' ')[1]);
    var longitude = double.parse(line.split(' ')[2]);

    if (latitude > GazaMap.topImage || latitude < GazaMap.bottomImage) {
      throw Exception("Out of Gaza Range : $line");
    }
    if (longitude > GazaMap.rightImage || longitude < GazaMap.leftImage) {
      throw Exception("Out of Gaza Range : $line");
    }

    return CityModel(
      name: name,
      latitude: latitude,
      longitude: longitude,
    );
  }

  String get name => _name;

  String getName() {
    if (_name.startsWith('.')) {
      return '${_name.split('.').last.replaceAll('_', ' ')} Street';
    } else {
      return _name.replaceAll('_', ' ');
    }
  }

  double get latitude => _latitude;
  double get longitude => _longitude;

  String getCityId() => '$_name$_latitude$_longitude';

  @override
  String toString() {
    return '$_name: ($_latitude, $_longitude)';
  }
}
