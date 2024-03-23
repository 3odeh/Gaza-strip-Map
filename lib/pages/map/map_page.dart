// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:project3_flutter/graph/shortest_path.dart';

import 'package:project3_flutter/graph/vertex_model.dart';
import 'package:project3_flutter/model/city_model.dart';
import 'package:project3_flutter/pages/map/gaza_map.dart';
import 'package:project3_flutter/pages/map/widget/city_marker_widget.dart';
import 'package:project3_flutter/pages/map/widget/input_city_widget.dart';
import 'package:project3_flutter/pages/map/widget/street_point_marker_widget.dart';
import 'package:project3_flutter/pages/widgets/Image.dart';
import 'package:project3_flutter/util/colors.dart';
import 'package:project3_flutter/util/text_style.dart';
import 'package:widget_arrows/widget_arrows.dart';

class MapPage extends StatefulWidget {
  final List<VertexModel<CityModel>?> table;
  const MapPage({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<(int, num)>? path;
  num? distance;
  VertexModel<CityModel>? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gaza Map",
          style: MyTextStyles.text_28L.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Row(
              children: [
                if (MediaQuery.of(context).size.width > 1100)
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 1100) / 2,
                  ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ArrowContainer(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const ImageHandle(
                            path: "assets/images/gaza4.png",
                            width: GazaMap.imageWidthPixel,
                            height: GazaMap.imageHeightPixel,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                        ...getAllPositions(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                InputCityWidget(
                  table: widget.table,
                  onRunTap: calculatePath,
                  distance: distance,
                  path: path,
                  selected: selected,
                  onClearTap: () {
                    setState(() {
                      path = null;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculatePath(
    VertexModel<CityModel> source,
    VertexModel<CityModel> target,
  ) {
    ShortestPath<CityModel> sp = ShortestPath<CityModel>(table: widget.table);
    var res = sp.dijkstraUpdate(
        start: source.currentVertex, destination: target.currentVertex);
    setState(() {
      path = res.$2;
      distance = res.$1;
    });
  }

  List<Widget> getAllPositions() {
    List<Widget> positions =
        List.generate(widget.table.length - 1, (index) => const SizedBox());

    for (var i = 1; i < widget.table.length; i++) {
      VertexModel<CityModel> vertex = widget.table[i]!;

      // check if street or city
      if (!vertex.info.name.startsWith('.')) {
        positions[i - 1] = (CityMarkerWidget(
          city: vertex.info,
          isSelected: vertex == selected,
          onTap: () {
            setState(() {
              if (vertex != selected) {
                selected = vertex;
              } else {
                selected = null;
              }
            });
          },
        ));
      } else {
        positions[i - 1] = (StreetPointMarkerWidget(
          city: vertex.info,
          isSelected: vertex == selected,
          onTap: () {
            setState(() {
              if (vertex != selected) {
                selected = vertex;
              } else {
                selected = null;
              }
            });
          },
        ));
      }
    }

    // check if street or city
    if (path != null) {
      for (int i = path!.length - 1; i > 0; i--) {
        VertexModel<CityModel> vertex = widget.table[path![i].$1]!;
        CityModel destinationCity = widget.table[path![i - 1].$1]!.info;

        if (!vertex.info.name.startsWith('.')) {
          // -1 cus the first index in table is null but here is value
          positions[path![i].$1 - 1] = CityMarkerWidget(
            city: vertex.info,
            destinationCity: destinationCity,
            colorPath: (i.isOdd) ? MyColors.primaryColor : MyColors.darkColor,
            isSelected: vertex == selected,
            onTap: () {
              setState(() {
                if (vertex != selected) {
                  selected = vertex;
                } else {
                  selected = null;
                }
              });
            },
          );
        } else {
          // -1 cus the first index in table is null but here is value
          positions[path![i].$1 - 1] = StreetPointMarkerWidget(
            city: vertex.info,
            destinationCity: destinationCity,
            colorPath: (i.isOdd) ? MyColors.primaryColor : MyColors.darkColor,
            isSelected: vertex == selected,
            onTap: () {
              setState(() {
                if (vertex != selected) {
                  selected = vertex;
                } else {
                  selected = null;
                }
              });
            },
          );
        }
      }
    }
    return positions;
  }

  // List<Widget> getAllDistance() {
  //   List<Widget> positions = [];

  //   int? pathIndex;
  //   if (path != null) {
  //     pathIndex = 0;
  //   }

  //   for (var i = 1; i < widget.table.length; i++) {
  //     VertexModel<CityModel> vertex = widget.table[i]!;
  //     bool tmp = pathIndex != null && // null that mean there is no path
  //         ++pathIndex < path!.length && // to ignore first index
  //         path![pathIndex - 1].$1 ==
  //             i; // check vertex index quality to set id destination

  //     if (tmp) {
  //       CityModel destinationCity = widget.table[path![pathIndex!].$1]!.info;

  //       double x = ((GazaMap.positionToX(
  //                   latitude: vertex.info.latitude,
  //                   longitude: vertex.info.longitude)) +
  //               (GazaMap.positionToX(
  //                   latitude: destinationCity.latitude,
  //                   longitude: destinationCity.longitude))) /
  //           2;
  //       double y = ((GazaMap.positionToY(
  //                   latitude: vertex.info.latitude,
  //                   longitude: vertex.info.longitude)) +
  //               (GazaMap.positionToY(
  //                   latitude: destinationCity.latitude,
  //                   longitude: destinationCity.longitude))) /
  //           2;
  //       positions.add(
  //         Positioned(
  //           top: y,
  //           left: x,
  //           child: Text(
  //             '${path![pathIndex].$2.toStringAsFixed(1)}km',
  //             style: MyTextStyles.text_8D.copyWith(
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //   return positions;
  // }
}
