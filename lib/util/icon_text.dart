import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/util/text.dart';

import '../consts/colors.dart';
import 'helpers/text_helper.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String? iconLabel;
  final Color? iconColor;
  const IconText({super.key,required this.icon,this.iconColor,this.iconLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon,color: iconColor?? colors['secondary']!.withOpacity(0.6),),
        SizedBox(width: 7,),
        CText(text: iconLabel??"", decorations: TextDecorations(
            weight: FontWeight.bold
        ),),
      ],
    );
  }
}
