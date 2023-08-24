import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../consts/colors.dart';
import 'icon_text.dart';

class CButton extends StatelessWidget {
  final Widget widget;
  final double? width,height,radius,padding;
  final Color? backgroundColor;
  final Function()? onClicked;
  const CButton({
    super.key,
    required this.widget,
    this.onClicked,
    this.backgroundColor,
    this.height,this.width,this.radius,this.padding
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        width: width??100,
        padding: EdgeInsets.all(padding??10),
        decoration: BoxDecoration(
            color: backgroundColor??colors['light-blue'],
            borderRadius: BorderRadius.circular(radius??10)
        ),
        child: widget,
      ),
    );
  }
}