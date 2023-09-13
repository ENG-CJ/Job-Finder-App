import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/api_url.dart';

import '../../consts/colors.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/icon_image.dart';
import '../../util/text.dart';

class JobHeader extends StatelessWidget {
  final String jobTitle, company;
  final String? logo;
  final void Function()? onClickIcon;
  final IconData icon;
  const JobHeader(
      {super.key,
      required this.jobTitle,
      required this.company,
      this.logo,
      this.icon = FontAwesomeIcons.bookmark,
      this.onClickIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            logo == null || logo == "" || logo == "no_profile"
                ? const IconImage(iconImagePath: "assets/default.png")
                : IconImage(
                    iconImagePath: "$API_BASE_URL/uploads/${logo!}",
                    fromNetwork: true),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: jobTitle,
                  decorations:
                      TextDecorations(fontSize: 18, family: "Poppins Medium"),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.building,
                      color: colors['light-grey'],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CText(
                      text: company,
                      decorations: TextDecorations(
                          color: colors['secondary'] as Color,
                          family: "Poppins Thin",
                          weight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        InkWell(
          onTap: onClickIcon,
          child: FaIcon(icon),
        )
      ],
    );
  }
}
