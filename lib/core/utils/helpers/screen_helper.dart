import 'package:flutter/material.dart';

class ScreenHelper {
  ScreenHelper._();

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double responsiveWidth(BuildContext context, double percentage) {
    return screenWidth(context) * percentage;
  }

  static double responsiveHeight(BuildContext context, double percentage) {
    return screenHeight(context) * percentage;
  }

  static bool isMobile(BuildContext context) {
    return screenWidth(context) < 600;
  }

  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= 600;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static SizedBox verticalSpace(double height) => SizedBox(height: height);

  static SizedBox horizontalSpace(double width) => SizedBox(width: width);

  static EdgeInsets paddingAll(double value) => EdgeInsets.all(value);

  static EdgeInsets paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static bool isAndroid(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.android;
  }

  static bool isIOS(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }
}
