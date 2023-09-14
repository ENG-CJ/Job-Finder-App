import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/colors.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/text.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20,
          left: 5,
          right: 5
      ),
      child: Container(
        margin: EdgeInsets.only(
            top: 20
        ),

        width: double.maxFinite,
        height: MediaQuery.sizeOf(context).height*0.25,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  colors['primary'] as Color,
                  // Color(0xff0974f1),
                  Color(0xff103783).withOpacity(0.8),
                ]
            ),
            borderRadius: BorderRadius.circular(20)

        ),
        child: Stack(
            clipBehavior: Clip.none,
            children:[

              Padding(
                padding: const EdgeInsets.only(
                    top: 40,
                    left: 20,
                    right: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(text: "BROWSE JOBs",
                      decorations: TextDecorations(
                          color: colors['white-color'] as Color,
                          fontSize: 28,
                          family: "Poppins Bold"
                      ),),
                    SizedBox(height: 5,),
                    CText(text: "that match your experience",
                      decorations: TextDecorations(
                        color: Colors.white70,
                        fontSize: 16,

                      ),),
                    SizedBox(height: 3,),
                    CText(text: "Ordered By most  ",
                      decorations: TextDecorations(
                        color: Colors.white70,
                        fontSize: 16,

                      ),),
                  ],
                ),
              ),
              Positioned(
                top: -30,
                right: 0,
                child: SizedBox(
                  // width: 300,
                    height: 260,
                    child: Image.asset("assets/brand.png"
                      ,)),
              ),

            ]
        ),
      ),
    );
  }
}