import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_image.dart';
import 'package:job_finder/util/profile.dart';
import 'package:job_finder/util/text.dart';

import '../../consts/colors.dart';

class AppliedPage extends StatelessWidget {
  const AppliedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 10,
              right: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconImage(
                  iconRadius: 40,
                    iconImagePath: "assets/google.png"),
                CText(text: "Applied Jobs",
                decorations: TextDecorations(
                  color: colors['secondary'] as Color,
                  fontSize: 20,
                  family: "Poppins SemiBold"
                ),),
                CButton(
                  onClicked: ()=> print("Filter"),
                    width: 45,
                    radius: 50,
                    backgroundColor: colors['primary']!.withOpacity(0.2),
                    widget: Center(child: FaIcon(FontAwesomeIcons.filter)))
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}
