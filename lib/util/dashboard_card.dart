import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/util/text.dart';

import '../consts/colors.dart';
import 'helpers/text_helper.dart';

class DashboardCard extends StatelessWidget {
  final String counterTitle, subtitle;
  final IconData? rightIcon;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double radius;
  final double iconSize;
  final Color iconColor;

  const DashboardCard(
      {super.key,
      required this.counterTitle,
      required this.subtitle,
      this.rightIcon,
      this.backgroundColor,
      this.gradient,
      this.radius = 15,
      this.iconSize = 50,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 18),
      child: Container(
          padding: EdgeInsets.all(18),
          width: double.maxFinite,
          decoration: BoxDecoration(
              gradient: gradient,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFdbdfe3).withOpacity(1),
                  offset: Offset(-1, 3),
                  blurRadius: 28,
                  spreadRadius: -4,
                ),
              ],
              color: backgroundColor ?? colors['primary'],
              borderRadius: BorderRadius.circular(radius)),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: counterTitle,
                          decorations: TextDecorations(
                              color: Colors.white,
                              fontSize: 28,
                              family: "Poppins Bold"),
                        ),
                        CText(
                            text: subtitle,
                            decorations: TextDecorations(
                                color: Color.fromARGB(238, 239, 238, 238),
                                fontSize: 15,
                                family: "Poppins Bold"))
                      ],
                    ),
                    FaIcon(
                      rightIcon,
                      size: iconSize,
                      color: iconColor,
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
