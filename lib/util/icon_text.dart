import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/util/text.dart';

import '../consts/colors.dart';
import 'helpers/text_helper.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String? iconLabel;
  final bool centered;
  final Color? iconColor;
  final double iconSize;
  final Color textColor;
  const IconText(
      {super.key,
      required this.icon,
      this.iconColor,
      this.iconLabel,
      this.centered = false,
      this.iconSize = 20,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          centered ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        FaIcon(
          size: iconSize,
          icon,
          color: iconColor ?? colors['secondary']!.withOpacity(0.6),
        ),
        SizedBox(
          width: 10,
        ),
        CText(
          text: iconLabel ?? "",
          decorations:
              TextDecorations(weight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }
}
