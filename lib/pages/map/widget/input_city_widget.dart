import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:project3_flutter/graph/vertex_model.dart';
import 'package:project3_flutter/model/city_model.dart';
import 'package:project3_flutter/util/colors.dart';
import 'package:project3_flutter/util/text_style.dart';

class InputCityWidget extends StatefulWidget {
  final List<VertexModel<CityModel>?> table;
  final List<(int, num)>? path;
  final num? distance;
  final VertexModel<CityModel>? selected;
  final Function() onClearTap;
  final Function(VertexModel<CityModel> source, VertexModel<CityModel> target)
      onRunTap;

  const InputCityWidget({
    Key? key,
    required this.table,
    required this.onRunTap,
    this.path,
    this.distance,
    this.selected,
    required this.onClearTap,
  }) : super(key: key);

  @override
  InputCityWidgetState createState() => InputCityWidgetState();
}

class InputCityWidgetState extends State<InputCityWidget> {
  VertexModel<CityModel>? source;
  VertexModel<CityModel>? target;
  String? inputError;
  SingleValueDropDownController sourceController =
      SingleValueDropDownController();
  SingleValueDropDownController targetController =
      SingleValueDropDownController();

  double dublicatedDistanceSum = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.selected != null)
            Card(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            widget.selected!.info.getName(),
                            style: MyTextStyles.text_24D.copyWith(
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Text(
                        "Latitude : ${widget.selected!.info.latitude.toStringAsFixed(6)}",
                        style: MyTextStyles.text_18D,
                      ),
                      Text(
                        "Longitude : ${widget.selected!.info.longitude.toStringAsFixed(6)}",
                        style: MyTextStyles.text_18D,
                      ),
                      if (!widget.selected!.info.name.startsWith('.'))
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  disabledBackgroundColor:
                                      MyColors.unselectedColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: (source == widget.selected ||
                                        target == widget.selected)
                                    ? null
                                    : () {
                                        setState(() {
                                          sourceController.dropDownValue =
                                              DropDownValueModel(
                                                  name: widget.selected!.info
                                                      .getName(),
                                                  value: widget
                                                      .selected!.currentVertex);
                                          source = widget.selected;
                                        });
                                      },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Set Source City",
                                    style: MyTextStyles.text_18L,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  disabledBackgroundColor:
                                      MyColors.unselectedColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: (source == widget.selected ||
                                        target == widget.selected)
                                    ? null
                                    : () {
                                        setState(() {
                                          targetController.dropDownValue =
                                              DropDownValueModel(
                                                  name: widget.selected!.info
                                                      .getName(),
                                                  value: widget
                                                      .selected!.currentVertex);
                                          target = widget.selected;
                                        });
                                      },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Set Target City",
                                    style: MyTextStyles.text_18L,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 50,
          ),
          DropDownTextField(
            controller: sourceController,
            enableSearch: true,
            clearOption: true,
            textFieldDecoration: InputDecoration(
              hintText: "Select Source",
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(12)),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.errorColor),
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: null,
              errorStyle: const TextStyle(fontSize: 0),
            ),
            dropDownItemCount: 5,
            dropdownRadius: 12,
            searchDecoration: const InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
            dropDownList: suggestionsList(),
            onChanged: (value) {
              setState(() {
                if (value is DropDownValueModel) {
                  source = widget.table[value.value];
                } else {
                  source = null;
                }
              });
            },
          ),
          const SizedBox(
            height: 15,
          ),
          DropDownTextField(
            enableSearch: true,
            clearOption: true,
            controller: targetController,
            textFieldDecoration: InputDecoration(
              hintText: "Select Source",
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(12)),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.errorColor),
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: null,
              errorStyle: const TextStyle(fontSize: 0),
            ),
            dropDownItemCount: 5,
            dropdownRadius: 12,
            searchDecoration: const InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
            dropDownList: suggestionsList(),
            onChanged: (value) {
              setState(() {
                if (value is DropDownValueModel) {
                  target = widget.table[value.value];
                } else {
                  target = null;
                }
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          if (inputError != null)
            Text(
              inputError!,
              textAlign: TextAlign.center,
              style: MyTextStyles.errorText_14,
            ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: MyColors.unselectedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                if (source == null && target == null) {
                  inputError = 'Please enter source and target cities';
                } else if (source == null) {
                  inputError = 'Please enter source city';
                } else if (target == null) {
                  inputError = 'Please enter target city';
                } else {
                  inputError = null;
                  widget.onRunTap(source!, target!);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Run",
                    style: MyTextStyles.text_18L,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          if (widget.path != null && widget.distance != null)
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Path :",
                    style: MyTextStyles.text_18D.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: widget.path!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          index = widget.path!.length - 1 - index;
                          String name = widget
                              .table[widget.path![index].$1]!.info
                              .getName();
                          num distance = widget.path![index].$2;

                          // for dublicated values
                          if ((index != 0 &&
                              name ==
                                  widget.table[widget.path![index - 1].$1]!.info
                                      .getName())) {
                            dublicatedDistanceSum += distance;
                            return const SizedBox();
                          } else {
                            if (dublicatedDistanceSum != 0) {
                              distance += dublicatedDistanceSum;
                              dublicatedDistanceSum = 0;
                            }
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (index != widget.path!.length - 1)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        '${distance.toStringAsFixed(2)}km',
                                        style: MyTextStyles.text_10D.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_right_alt,
                                      size: 35,
                                    ),
                                  ],
                                ),
                              Text(
                                name.replaceAll('_', ' '),
                              ),
                            ],
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Distance : ${widget.distance!.toStringAsFixed(2)}km",
                    style: MyTextStyles.text_18D.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: MyColors.unselectedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: widget.onClearTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Clear",
                            style: MyTextStyles.text_18L,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<DropDownValueModel> suggestionsList() {
    List<DropDownValueModel> suggestions = [];
    for (var i = 1; i < widget.table.length; i++) {
      if (!(source != null && source!.currentVertex == i ||
              target != null && target!.currentVertex == i) &&
          !widget.table[i]!.info.name.startsWith('.')) {
        suggestions.add(DropDownValueModel(
            name: widget.table[i]!.info.getName(), value: i));
      }
    }
    return suggestions;
  }
}
