import 'package:flutter/material.dart';
import 'package:project3_flutter/model/city_model.dart';
import 'package:project3_flutter/pages/map/gaza_map.dart';
import 'package:project3_flutter/util/colors.dart';
import 'package:project3_flutter/util/text_style.dart';
import 'package:widget_arrows/arrows.dart';
import 'package:widget_arrows/widget_arrows.dart';

class CityMarkerWidget extends StatelessWidget {
  final CityModel city;
  final CityModel? destinationCity;
  final Color? colorPath;
  final bool isSelected;
  final Function() onTap;

  const CityMarkerWidget({
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
          ) -
          52,
      top: GazaMap.positionToY(
            latitude: city.latitude,
            longitude: city.longitude,
          ) -
          31,
      child: _dataWidget(),
    );
  }

  Widget _dataWidget() => SizedBox(
        width: 110,
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              city.getName(),
              style: MyTextStyles.text_10D.copyWith(
                fontWeight: FontWeight.bold,
                color: (isSelected) ? MyColors.pathColor : MyColors.darkColor,
                fontSize: (isSelected) ? 12 : 10,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            ArrowElement(
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
                  Icons.place,
                  color:
                      (isSelected) ? MyColors.pathColor : MyColors.primaryColor,
                  size: (isSelected) ? 20 : 15,
                ),
              ),
            ),
          ],
        ),
      );
}
