import 'package:flutter/material.dart';
import 'package:project3_flutter/graph/vertex_model.dart';
import 'package:project3_flutter/model/city_model.dart';
import 'package:project3_flutter/pages/map/map_page.dart';
import 'package:project3_flutter/pages/splash/input_file.dart';
import 'package:project3_flutter/util/colors.dart';
import 'package:project3_flutter/util/text_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  String? error;
  List<String> ignoreLines = [];
  List<VertexModel<CityModel>?>? table;

  @override
  void initState() {
    super.initState();
    readFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "Gaza",
              style: MyTextStyles.text_28D.copyWith(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: (error != null)
                  ? Column(
                      children: [
                        Text(
                          error!,
                          style: MyTextStyles.errorText_20,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        IconButton(
                          onPressed: readFile,
                          icon: Icon(
                            Icons.refresh,
                            color: MyColors.errorColor,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  : (ignoreLines.isNotEmpty)
                      ? Column(
                          children: [
                            Text(
                              "Ignore Lines",
                              style: MyTextStyles.errorText_20.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ...ignoreLines
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e,
                                      style: MyTextStyles.text_20D,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                                .toList(),
                            const SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                    MyColors.unselectedColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (c) => MapPage(
                                      table: table!,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Show Map",
                                  style: MyTextStyles.text_18L,
                                ),
                              ),
                            ),
                          ],
                        )
                      : CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void readFile() async {
    setState(() {
      error = null;
    });

    table = await InputFile.readMapFile(
      onError: (fileError) {
        error = fileError;
      },
      ignoreLine: (String line) {
        ignoreLines.add(line);
      },
    );

    setState(() {});

    if (table != null && ignoreLines.isEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (c) => MapPage(
            table: table!,
          ),
        ),
      );
    }
  }
}
