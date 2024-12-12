import 'package:flutter/material.dart';

class Responsive{

   double baseHeight = 812.0;
   double baseWidth = 375.0;

  double screenAwareSize(double size, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth < screenHeight
        ? screenHeight / baseHeight
        : screenWidth / baseWidth;

    return size * scaleFactor;
  }

  double width(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.width / baseWidth;
  }

  double height(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.height / baseHeight;
  }
}

