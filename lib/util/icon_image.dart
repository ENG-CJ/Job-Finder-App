import 'package:flutter/cupertino.dart';

import '../consts/colors.dart';

class IconImage extends StatelessWidget {
  final Color? backgroundColor;
  final String iconImagePath;
  final bool fromNetwork;
  final double? iconRadius, width, height;

  const IconImage(
      {super.key,
      required this.iconImagePath,
      this.height,
      this.width,
      this.backgroundColor,
      this.iconRadius,
      this.fromNetwork = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      width: width ?? 50,
      height: height ?? 50,
      decoration: BoxDecoration(
          color: backgroundColor ?? colors['primary']!.withOpacity(0.1),
          borderRadius: BorderRadius.circular(iconRadius ?? 10)),
      child: fromNetwork
          ? Image.network(iconImagePath)
          : Image.asset(iconImagePath),
    );
  }
}
