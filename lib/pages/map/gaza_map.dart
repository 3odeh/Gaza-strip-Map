import 'dart:math';

class GazaMap {
  // Earth's radius in kilometers
  static const double _earthRadius = 6371;

  // latitude for height (y), longitude for width (x)
  static const double topImage = 31.594187903272655; //top latitude
  static const double bottomImage = 31.219688094263507; //bottom latitude
  static const double leftImage = 34.209147954667934; //left longitude
  static const double rightImage = 34.56777473118603; //right longitude

  static const double imageWidthKm = 34.5; // Width of gaza image = 34.5km
  static const double imageHeightKm = 42; // Height of gaza image = 42km

  static const double imageWidthPixel = 600; // Width of gaza image = 600p
  static const double imageHeightPixel = 800; // Height of gaza image = 800p

  static const double imageWidthRatio = imageWidthPixel /
      imageWidthKm; // This how mutch one km take pixles in width (Pixels per km)
  static const double imageHeightRatio = imageHeightPixel /
      imageHeightKm; // This how mutch one km take pixles in Height (Pixels per km)

  static double calculateDistance({
    required double latitude1,
    required double longitude1,
    required double latitude2,
    required double longitude2,
  }) {
    // Convert degrees to radians
    double lat1Rad = _degreeToRadian(latitude1);
    double lon1Rad = _degreeToRadian(longitude1);
    double lat2Rad = _degreeToRadian(latitude2);
    double lon2Rad = _degreeToRadian(longitude2);

    // Point1 = (φ1,λ1) , Point2 = (φ2,λ2)
    // Haversine formula:
    // v = sin²(Δφ/2) + cos φ1 * cos φ2 * sin²(Δλ/2)
    // c = 2 * atan2(√v, √(1−v))
    // distance = raduis * c
    final v = pow(sin((lat2Rad - lat1Rad) / 2), 2) +
        (cos(lat1Rad) * cos(lat2Rad) * pow(sin((lon2Rad - lon1Rad) / 2), 2));
    final c = 2 * atan2(sqrt(v), sqrt(1 - v));
    final distance = _earthRadius * c;

    return distance;
  }

  static double _degreeToRadian(double degree) => degree * pi / 180;

  static double positionToX({
    required double latitude,
    required double longitude,
  }) {
    // calculate distance (width) between the left of image longitude and city longitude
    // with same latitude (height)
    double widthKm = calculateDistance(
      latitude1: latitude,
      longitude1: longitude,
      latitude2: latitude,
      longitude2: leftImage,
    );

    // Convert distance from km to pixels
    double widthPixcel = widthKm * imageWidthRatio;
    return widthPixcel;
  }

  static double positionToY({
    required double latitude,
    required double longitude,
  }) {
    // calculate distance (height) between the top of image latitude and city latitude
    // with same longitude (width)
    double heightKm = calculateDistance(
      latitude1: latitude,
      longitude1: longitude,
      latitude2: topImage,
      longitude2: longitude,
    );
    // Convert distance from km to pixels
    double heightPixcel = heightKm * imageHeightRatio;
    return heightPixcel;
  }
}
