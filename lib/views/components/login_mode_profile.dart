import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/services/local/local_storage.dart';
import 'package:job_finder/views/pages/login_page.dart';

import '../../consts/api_url.dart';
import '../../consts/colors.dart';
import '../../util/buton.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/icon_text.dart';
import '../../util/profile.dart';
import '../../util/text.dart';
import '../pages/home_page.dart';

class LoginModeProfile extends StatelessWidget {
  final username;
  final imagePath;
  const LoginModeProfile(
      {super.key, required this.username, this.imagePath = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: imagePath == '' ||
                  imagePath == "no_profile" ||
                  imagePath == "null" ||
                  imagePath == null
              ? ProfileImage(imagePath: "assets/default.png")
              : ProfileImage(
                  fromNetwork: true,
                  imagePath: "$API_BASE_URL/uploads/$imagePath",
                  asBackgroundImage: true,
                ),
        ),
        SizedBox(
          height: 4,
        ),
        CText(
          text: username,
          decorations: TextDecorations(
              color: colors['white-color'] as Color,
              fontSize: 21,
              family: "Poppins SemiBold"),
        ),
        SizedBox(
          height: 4,
        ),
        CButton(
          onClicked: () {
            LocalStorageSharedPref()
                .removeLocalData("userData")
                .whenComplete(() {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) => Login()), (route) => false);
            });
          },
          widget: IconText(
            icon: FontAwesomeIcons.rightFromBracket,
            iconLabel: "Logout",
          ),
        )
      ],
    );
  }
}
