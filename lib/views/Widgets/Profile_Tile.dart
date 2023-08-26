import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

import '../../consts/colors.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.color,
    required this.leadingIconColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? color;
  final Color? leadingIconColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? colors['primary'] : colors['secondary'];
    return ListTile(
      shape: const StadiumBorder(),
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: colors['primary']?.withOpacity(0.1)),
        child: Icon(icon,color: leadingIconColor,),
      ),
      title: CText(
        text: title,
        decorations: TextDecorations(
            color: color != null ? color!.withOpacity(0.8) : iconColor!, fontSize: 18, weight: FontWeight.w400),
      ),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)),
        child:  Icon(
          FontAwesomeIcons.angleRight,
          size: 18.0,
          color: colors['primary'],
        ),
      )
          : null,
    );
  }
}
