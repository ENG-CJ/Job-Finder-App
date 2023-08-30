import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../consts/colors.dart';
import '../../util/buton.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/icon_text.dart';
import '../../util/profile.dart';
import '../../util/text.dart';

class LoginModeProfile extends StatelessWidget {
  const LoginModeProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ProfileImage(imagePath: "assets/google.png"),
        ),

        SizedBox(height: 4,),
        CText(text: "Abdulrahman",
          decorations: TextDecorations(
              color: colors['white-color'] as Color,
              fontSize: 21,
              family: "Poppins SemiBold"
          ),),
        SizedBox(height: 4,),
        CButton(
          widget: IconText(icon: FontAwesomeIcons.rightFromBracket,iconLabel: "Logout",),
        )
      ],
    );
  }
}