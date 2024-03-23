import 'dart:math';

import 'package:flutter/material.dart';

class MyColors {
  static Color primaryColor = const Color(0xFF3B49E7);
  static Color secondaryColor = const Color(0xFF6E76CE);
  static Color cellPinnedColor = const Color(0xFF3B49E7).withOpacity(0.3);
  static Color backgroundGreyColor = const Color(0xFFF7F7F8);
  static Color darkColor = const Color(0xFF000000);
  static Color lightColor = const Color(0xFFFFFFFF);
  static Color textLightColor = const Color(0xFFFFFFFF);
  static Color textDarkColor = const Color(0xFF000000);
  static Color hintTextColor = const Color(0xFF999999);
  static Color backgroundWhiteBlueColor = const Color(0xFFEBEFF8);
  static Color inProgressTextColor = const Color(0xFF1F4497);
  static Color completeTextColor = const Color(0xFF00A04A);
  static Color unselectedColor = const Color(0xFF999999);
  static Color errorColor = const Color(0xFFE01E3E);
  static Color loadingBackgroundColor =
      const Color(0xFF9E9E9E).withOpacity(0.5);
  static Color dividerColor = const Color(0xFFE6E6E6);
  static Color borderColor = const Color(0xFFE6E6E6);
  static Color availableTextColor = const Color(0xFF64C564);
  static Color availableBackgroundColor = const Color(0xFFEDF8EF);
  static Color pathColor = const Color(0xFFEA4225);
  static Color notAvailableBackgroundColor = const Color(0xFFFBEAE6);
  static Color dialogbackgroundColor = const Color(0xFFFFFFFF);
  static Color onColor = const Color(0xFF3BA85A);
  static Color offColor = const Color(0xFF242424);
  static Color progressFillColor = const Color(0xFF3E60B5);
  static Color completeIconColor = const Color(0xFF0DA10D);
  static Color cancelIconColor = const Color(0xFFFF1818);
  static Color progressIconColor = const Color(0xFF2196F3);

  static Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255, // Alpha (opacity)
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  static Color hexToColor(String hexColor) {
    // Remove any leading '#' character
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Parse the hex color string to an integer
    int hexValue = int.parse(hexColor, radix: 16);

    // Check the length of the hex string to determine if it's in the format RRGGBB or AARRGGBB
    if (hexColor.length == 6) {
      // If it's 6 characters, assume it's in the format RRGGBB and set the alpha (opacity) to 255
      return Color(0xFF000000 + hexValue);
    } else if (hexColor.length == 8) {
      // If it's 8 characters, assume it's in the format AARRGGBB
      return Color(hexValue);
    } else {
      // Invalid input, return a default color (e.g., white)
      return Colors.white;
    }
  }

  static String colorToHex(Color color) {
    // Ensure that the alpha value is included (it might be omitted in some cases)
    String alpha = color.alpha.toRadixString(16).padLeft(2, '0');
    String red = color.red.toRadixString(16).padLeft(2, '0');
    String green = color.green.toRadixString(16).padLeft(2, '0');
    String blue = color.blue.toRadixString(16).padLeft(2, '0');

    // Combine the components to form the hex color code
    return '#$alpha$red$green$blue';
  }
}
