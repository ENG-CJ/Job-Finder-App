import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/consts/user_profile_enum.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/radio_listile_button.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/pages/registrations/conpany.dart';
import 'package:job_finder/views/pages/registrations/user_reg.dart';

class UserTypePage extends StatefulWidget {
  const UserTypePage({super.key});

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  USER_PROFILE? user_profile=USER_PROFILE.NONE;
  bool isSelected=false;

  bool hasTrueState(USER_PROFILE stateValue)=> stateValue==user_profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                text: "Select Your Profile Type",
                decorations: TextDecorations(
                    fontSize: 30,
                    family: "Poppins Bold",
                    color: colors['secondary'] as Color),
              ),
              SizedBox(
                height: 10,
              ),
              CText(
                text:
                    "The Profile type will define the accessibility for this app",
                decorations:
                    TextDecorations(fontSize: 18, family: "Poppins Light"),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),

              RadioListTileButton<USER_PROFILE>(
                  decorations: hasTrueState(USER_PROFILE.company) ?
                  TextDecorations(
                      family: "Poppins Bold",
                      color: Colors.white,
                      fontSize: 16
                  ) : null,
                isSelected: hasTrueState(USER_PROFILE.company),
                selectedTileBackgroundColor:  colors['primary'] as Color ,
                  selectedTileTextColor: Colors.white,
                  checkBoxColor: hasTrueState(USER_PROFILE.company) ? MaterialStatePropertyAll<Color>(Colors.white)
                   : null,
                  radioLabel: "Company Profile", value: USER_PROFILE.company, groupValue: user_profile!, onChangedValue: (value){
                if(value!=null){
                  setState(() {
                    isSelected=true;
                    user_profile=value;
                  });
                }
              }),
              SizedBox(height: 10,),
              RadioListTileButton<USER_PROFILE>(
                decorations: hasTrueState(USER_PROFILE.applicant) ?
                  TextDecorations(
                    family: "Poppins Bold",
                    color: Colors.white,
                    fontSize: 16
                  ) : null,
                  isSelected: hasTrueState(USER_PROFILE.applicant),
                  selectedTileBackgroundColor:  colors['primary'] as Color ,
                  selectedTileTextColor: Colors.white,
                  checkBoxColor:  hasTrueState(USER_PROFILE.applicant) ? MaterialStatePropertyAll<Color>(Colors.white) : null,
                  radioLabel: "User Profile", value: USER_PROFILE.applicant, groupValue: user_profile!, onChangedValue: (value){
                  if(value!=null){
                    setState(() {
                      isSelected=true;
                      user_profile=value;
                    });
                  }
              }),



              SizedBox(
                height: 30,
              ),
              CButton(
                onClicked: (){
                  if(isSelected){
                    if(user_profile == USER_PROFILE.company){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterCompany()));
                    }
                    else{
                      if(user_profile == USER_PROFILE.applicant){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserReg()));
                      }
                    }
                    // route registration page, with the value of Selected Profile
                    return;
                  }

                },
                selected: isSelected,
                  selectedColor: colors['primary']!.withOpacity(0.3) as Color,
                  width: double.maxFinite,
                  padding: 20,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.angleRight),
                      SizedBox(
                        width: 16,
                      ),
                      CText(
                        text: "Continue",
                        decorations: TextDecorations(
                            family: "Poppins Bold", fontSize: 16),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
