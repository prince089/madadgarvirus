import 'package:flutter/cupertino.dart';

extension SizeExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  //844/350 = 2.52
  double get personStackImage => screenHeight / 2.41;

  //radius
  double get radius15 => screenHeight / 56.27;
  double get radius20 => screenHeight / 42.2;
  double get radius30 => screenHeight / 28.13;
  double get radius50 => screenHeight / 16.88;

  //app icons
  double get iconSize24 => screenHeight / 35.17;
  double get iconSize16 => screenHeight / 52.75;

  //height and width
  double get height09 => screenHeight / 93.77;
  double get height20 => screenHeight / 42.2;
  double get height45 => screenHeight / 18.75;
  double get height101 => screenWidth / 8.35;
  double get height650 => screenWidth / 1.29;
  double get width09 => screenHeight / 93.77;
  double get width20 => screenWidth / 42.2;
  double get width45 => screenWidth / 18.75;
  double get width650 => screenWidth / 1.29;
  double get width101 => screenWidth / 8.35;
}
