import 'package:flutter/cupertino.dart';
import 'package:job_finder/util/helpers/text_helper.dart';

class CText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final bool wrapText;
  final int maxLines;
  final bool createMaxLines;
  final TextDecorations? decorations;
  const CText(
      {super.key,
      required this.text,
      this.decorations,
      this.textAlign,
      this.createMaxLines = true,
      this.wrapText = true,
      this.maxLines = 3});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: createMaxLines ? maxLines : null,
      overflow: wrapText ? TextOverflow.ellipsis : null,
      textAlign: textAlign,
      style: TextStyle(
          color: decorations?.color,
          fontSize: decorations?.fontSize,
          fontFamily: decorations?.family,
          fontWeight: decorations?.weight,
          height: decorations?.height),
    );
  }
}
