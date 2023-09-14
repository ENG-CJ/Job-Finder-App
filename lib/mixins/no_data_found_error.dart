import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../util/buton.dart';
import '../util/helpers/text_helper.dart';
import '../util/text.dart';

mixin NoDataErrorMixin {
  Center noDataError(
      BuildContext context,
      String? buttonText,
      String? errorMessage,
      String? description,
      void Function(BuildContext context, dynamic result)? callback) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.sizeOf(context).height * 0.33,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFFd4cadf).withOpacity(1),
            offset: Offset(-1, 0),
            blurRadius: 26,
            spreadRadius: -1,
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: -100,
                left: 80,
                child: SizedBox(
                  width: 220,
                  height: 220,
                  child: Image.asset("assets/nodata.png"),
                )),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CText(
                      text: errorMessage ?? "No Data Found Based On Your Query",
                      decorations: TextDecorations(
                          color: colors['error-color'] as Color,
                          family: "Poppins SemiBold"),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 10),
                      child: CText(
                        text: description ??
                            "Try Again, And Search Predfined Job",
                        decorations: TextDecorations(
                            color: colors['secondary'] as Color,
                            family: "Poppins Medium"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CButton(
                        onClicked: () {
                          if (callback != null) {
                            callback(context, null);
                          }
                        },
                        width: 150,
                        padding: 14,
                        backgroundColor: colors['error-color'],
                        widget: Center(
                            child: CText(
                          text: buttonText ?? "Close",
                          decorations: TextDecorations(
                              color: Colors.white, family: "Poppins SemiBold"),
                        )))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
