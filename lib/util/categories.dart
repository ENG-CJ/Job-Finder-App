import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

import '../consts/colors.dart';

class Categories extends StatelessWidget {
  final String categoryName;
  final void Function()? onTap;
  const Categories({super.key, required this.categoryName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: colors['light-grey'] as Color,
            borderRadius: BorderRadius.circular(10)),
        child: CText(
          decorations: TextDecorations(family: "Poppins Light"),
          text: categoryName,
        ),
      ),
    );
  }
}
