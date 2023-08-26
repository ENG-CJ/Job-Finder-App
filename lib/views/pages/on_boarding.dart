import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/pages/login_page.dart';
import 'package:job_finder/views/pages/user_type_page.dart';
class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      controllerColor: colors['primary'],
     pageBackgroundColor: Colors.white,
      finishButtonText: "Get Started",
      trailingFunction: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> Login())),
      onFinish: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> UserTypePage())),
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: colors['primary'] as Color,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28)
        )
      ),
      skipTextButton: CText(text: "SKIP",
      decorations: TextDecorations(
        color: Colors.white,
        fontSize: 20,
        family: "Poppins SemiBold"

      ),),
      background: [
        Image.asset("assets/job-unlock.png"),
        Image.asset("assets/remote.png"),
        Image.asset("assets/notify-1.png"),
        Hero(

            tag: "image-1",
        child: Image.asset("assets/nocard-1.png")),
      ],
      imageVerticalOffset: 50,
      headerBackgroundColor: colors['primary']!.withOpacity(0.9) as Color,
      speed: 1.2,
      totalPage: 4,
      trailing: CText(text: "LOGIN",
      decorations: TextDecorations(
        color: Colors.white,
        family: "Poppins SemiBold",
        fontSize: 18
      ),),
      pageBodies: [
        Padding(
          padding: const EdgeInsets.only(top: 460),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                CText(text: "FIND A JOB THAT MEETS",
                decorations: TextDecorations(
                  fontSize: 25,
                  color: colors['primary'] as Color,
                  family: "Poppins Bold"
                ),),
                CText(text: "Your Qualifications And Experinece",
                  decorations: TextDecorations(
                      fontSize: 16,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 460),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(

              children: [
                CText(text: "REMOTE JOBS",
                  decorations: TextDecorations(
                      fontSize: 29,
                      color: colors['primary'] as Color,
                      family: "Poppins Bold"
                  ),),
                CText(text: "You Can find Remote jobs",
                  decorations: TextDecorations(
                      fontSize: 15,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
                CText(text: "Relevant Your Qualification",
                  decorations: TextDecorations(
                      fontSize: 15,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 460),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                CText(text: "GET NOTIFICATIONS",
                  decorations: TextDecorations(
                      fontSize: 28,
                      color: colors['primary'] as Color,
                      family: "Poppins Bold"
                  ),),
                CText(text: "When the Company Accept",
                  decorations: TextDecorations(
                      fontSize: 15,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
                CText(text: "Your Request, Get Notify Immediately",
                  decorations: TextDecorations(
                      fontSize: 15,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 460),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                CText(text: "NO CREDIT CARDS HERE!",
                  decorations: TextDecorations(
                      fontSize: 25,
                      color: colors['primary'] as Color,
                      family: "Poppins Bold"
                  ),),
                CText(text: "Feel free to Join, Only Registration",
                  decorations: TextDecorations(
                      fontSize: 16,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
                CText(text: "Register Free account as a company",
                  decorations: TextDecorations(
                      fontSize: 16,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
                CText(text: "or as a user GET STARTED NOW",
                  decorations: TextDecorations(
                      fontSize: 16,
                      color: colors['secondary'] as Color,
                      family: "Poppins Medium"
                  ),),
              ],
            ),
          ),
        ),

      ],

    );
  }
}
