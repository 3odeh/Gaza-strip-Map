import 'package:flutter/material.dart';
import 'package:project3_flutter/model/city_model.dart';
import 'package:project3_flutter/pages/map/gaza_map.dart';
import 'package:project3_flutter/util/colors.dart';
import 'package:widget_arrows/arrows.dart';
import 'package:widget_arrows/widget_arrows.dart';

class StreetPointMarkerWidget extends StatelessWidget {
  final CityModel city;
  final CityModel? destinationCity;
  final Color? colorPath;
  final bool isSelected;
  final Function() onTap;
  const StreetPointMarkerWidget({
    Key? key,
    required this.city,
    this.destinationCity,
    this.colorPath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: GazaMap.positionToX(
        latitude: city.latitude,
        longitude: city.longitude,
      ),
      top: GazaMap.positionToY(
        latitude: city.latitude,
        longitude: city.longitude,
      ),
      child: _widget(),
    );
  }

  Widget _widget() => ArrowElement(
        id: city.getCityId(),
        targetId: destinationCity?.getCityId(),
        arcDirection: ArcDirection.Auto,
        targetAnchor: const Alignment(0, 1),
        sourceAnchor: const Alignment(0, 1),
        color: colorPath?.withOpacity(0.7) ??
            MyColors.primaryColor.withOpacity(0.7),
        stretch: 0,
        width: 2,
        tipLength: 5,
        bow: 0,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            Icons.circle,
            color: (isSelected) ? MyColors.pathColor : MyColors.darkColor,
            size: 5,
          ),
        ),
      );
}
