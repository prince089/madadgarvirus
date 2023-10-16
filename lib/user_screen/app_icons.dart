import 'package:flutter/cupertino.dart';
import 'package:madadgarvirus/utils/extension.dart';

import '../utils/app_constants.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = kLighterColor,
    this.iconColor = const Color.fromRGBO(255, 255, 255, 1),
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: context.iconSize16,
      ),
    );
  }
}
