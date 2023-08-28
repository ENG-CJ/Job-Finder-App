import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/mixins/messages.dart';
import 'package:job_finder/util/helpers/custom_text_field.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

import '../../../consts/colors.dart';
import '../../../util/buton.dart';
import '../login_page.dart';

class RegisterCompany extends StatelessWidget with Messages{
  const RegisterCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController();
    bool _isDropdownVisible = false;
    List<String> _options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
    String _selectedOption = '';
    bool _termsAndCondChecked = false;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8), // Shadow color
                    spreadRadius: 6, // Spread radius
                    blurRadius: 0, // Blur radius
                    offset: Offset(0, 10), // Offset in x and y directions
                  ),
                ]),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            // color: Colors.grey,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CText(
                                    text: comRegTitle,
                                    decorations: TextDecorations(
                                      fontSize: 24,
                                      family: 'Roboto-Bold',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                CText(
                                  text: comSubTitle,
                                  decorations: TextDecorations(
                                      fontSize: 16, family: 'Roboto-Light'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  height: 80,
                                  width: 80,

                                  margin:
                                      const EdgeInsets.only(left: 16, top: 20),
                                  decoration: BoxDecoration(
                                      // color: Colors.red
                                      ),
                                  child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset("assets/img_holder.png"),
                                    ),
                                    Positioned(
                                      top: 40,
                                      right: 0,
                                      left: 45,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors['primary'],
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            // Handle camera icon press
                                          },
                                          color: Colors.red,
                                          icon: Icon(Icons.camera_alt_outlined,color: Colors.yellow,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        txtInputType: TextInputType.text,
                        hintText: comName,
                        prefixIcon: Icon(FontAwesomeIcons.mountainCity)),

                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        txtInputType: TextInputType.number,
                        hintText: comPhone,
                        prefixIcon: Icon(Icons.phone_outlined)),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        txtInputType: TextInputType.emailAddress,
                        hintText: comEmail,
                        prefixIcon: Icon(Icons.alternate_email)),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(height: 8,),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CText(
                        text: comAddresses,
                        decorations: TextDecorations(
                            fontSize: 16, family: 'Roboto-Light'),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    CustomTextField(
                      txtInputType: TextInputType.text,
                      hintText: comCity,
                      prefixIcon: Icon(Icons.location_city_rounded),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    CustomTextField(
                        txtInputType: TextInputType.text,
                        hintText: comAddress,
                        prefixIcon: Icon(FontAwesomeIcons.addressBook)),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      txtInputType: TextInputType.text,
                      hintText: comCountry,
                      prefixIcon: Icon(Icons.flag),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CText(
                        text: comIndustry,
                        decorations: TextDecorations(
                            fontSize: 16, family: 'Roboto-Light'),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    TextField(
                      controller: _textEditingController,
                      onTap: () {
                        _isDropdownVisible = !_isDropdownVisible;
                        //Note: -> Add State make visible to the dropdown item
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 14, 10, 10),
                        // border: InputBorder.none,
                        // focusedBorder: InputBorder.none,
                        hintText: 'Select an option',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                    if (_isDropdownVisible)
                      Container(
                        constraints: BoxConstraints(maxHeight: 150.0),

                        child: ListView.builder(
                          itemCount: _options.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                _selectedOption = _options[index];
                                _textEditingController.text = _selectedOption;
                                _isDropdownVisible = false;
                                FocusScope.of(context).unfocus(); // Close the keyboard
                                //Note: -> Add State make visible to the dropdown item
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(_options[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 12,),
                    Row(
                      children: [
                        Checkbox(
                          value: _termsAndCondChecked,
                          onChanged: (bool? newValue) {
                            //? -> Add here the state to check the checkbox
                          },
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: signUpConditionTxt,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Light',
                                      color: Colors.black)),
                              WidgetSpan(
                                  child: SizedBox(
                                    width: 5,
                                  )),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    // Handle the onTap action for the terms and conditions
                                  },
                                  child: CText(
                                    text: tTermsAndConditions,
                                    // Apply the desired style for the TextButton-like text
                                    decorations: TextDecorations(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CButton(
                        onClicked: (){
                          showDialog(context: context, builder: (context){
                            return showInfo(context,"No Database Configured, Only Click Ok to Continue😊","Jon Finder",
                                    () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> Login()));
                                }

                            );
                          });
                        },
                          width: double.maxFinite,
                          padding: 14,
                          radius: 4,
                          backgroundColor: colors['secondary'],
                          widget: Center(
                            child: CText(
                              text: tRegBtn,
                              decorations: TextDecorations(
                                  fontSize: 20,
                                  family: 'Roboto-Regular',
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
