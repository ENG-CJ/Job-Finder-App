import 'package:flutter/cupertino.dart';
import 'package:job_finder/util/helpers/text_helper.dart';

class CText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextDecorations? decorations;
  const CText({super.key,required this.text, this.decorations,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      textAlign: textAlign,
      style: TextStyle(
        color: decorations?.color,
        fontSize: decorations?.fontSize,
        fontFamily: decorations?.family,
        fontWeight: decorations?.weight,
        height: decorations?.height
      ),

    );
  }
}
