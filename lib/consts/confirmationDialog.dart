import 'package:flutter/material.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key,
      required this.title,
      required this.alertContent,
      this.leftBtnTxt,
      this.rightBtnTxt,
      required this.callBackFunction});

  final String title;
  final String alertContent;
  final String? leftBtnTxt;
  final String? rightBtnTxt;
  final VoidCallback callBackFunction;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CText(
        text: title,
        decorations: TextDecorations(
            family: "Poppins Bold", fontSize: 20, weight: FontWeight.w400),
      ),
      content: CText(
        text: alertContent,
        decorations: TextDecorations(
            family: "Poppins Medium", fontSize: 16, weight: FontWeight.w400,color: Colors.black87),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: CText(
              text: leftBtnTxt ?? "Cancel",
            )),
        TextButton(
            onPressed: () {
              callBackFunction();
              Navigator.pop(context);
            },
            child: CText(
              text: rightBtnTxt ?? "Ok",
            )),
      ],
    );
  }
}
