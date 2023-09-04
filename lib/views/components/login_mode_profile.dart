import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/services/local/local_storage.dart';

import '../../consts/colors.dart';
import '../../util/buton.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/icon_text.dart';
import '../../util/profile.dart';
import '../../util/text.dart';

class LoginModeProfile extends StatelessWidget {
  final username;
  const LoginModeProfile({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ProfileImage(imagePath: "assets/google.png"),
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
              Navigator.pop(context);
              Navigator.pop(context);
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
