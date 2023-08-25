import 'package:flutter/material.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

import '../consts/colors.dart';

mixin Messages{


  AlertDialog showConfirmation(BuildContext context,String message,String messageTitle,
      {void Function()? onConfirm}){
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17)
      ),
      title: CText(text: messageTitle,
        decorations: TextDecorations(
            color: colors['error-color'] as Color,
            fontSize: 20,
            family: "Poppins Bold"
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(text: message,
            decorations: TextDecorations(
                color: colors['secondary'] as Color,
                fontSize: 17,
                height: 1.3
            ),)
        ],
      ),
      actions: [
        CButton(
            onClicked: ()=> Navigator.pop(context),
            widget: Center(child: CText(text: "No",
              decorations: TextDecorations(
                  family: "Poppins SemiBold"
              ),))),
        CButton(
            onClicked: onConfirm,
            backgroundColor:  colors['error-color'] as Color,
            widget: Center(child: CText(text: "Yes",
              decorations: TextDecorations(
                  color:  colors['white-color'] as Color,
                  family: "Poppins SemiBold"
              ),
            ))),
      ],
    );
  }

  AlertDialog showError(BuildContext context,String errorMessage,[String errorTitle="Error"]){
    return AlertDialog(
      title: CText(text:  errorTitle,
      decorations: TextDecorations(
        fontSize: 17,
        family: "Poppins SemiBold"
      ),),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(text: errorMessage,
            decorations: TextDecorations(
                color: colors['error-color']!.withOpacity(0.8) as Color,
                fontSize: 17,
                family: "Poppins SemiBold",
                height: 1.3
            ),)
        ],
      ),
      actions: [
        CButton(
            onClicked: ()=> Navigator.pop(context),
            backgroundColor:  colors['primary'] as Color,
            widget: Center(child: CText(text: "Ok",
              decorations: TextDecorations(
                  color:  colors['white-color'] as Color,
                  family: "Poppins SemiBold"
              ),
            ))),
      ],
    );
  }



}