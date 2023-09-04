import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/mixins/messages.dart';
import 'package:job_finder/modals/users/user.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/util/custom_text_field.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../consts/colors.dart';
import '../../../util/buton.dart';
import '../login_page.dart';

class RegisterCompany extends StatelessWidget with Messages {
  RegisterCompany({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String type = "Company";

  TextEditingController comNameController = TextEditingController();
  TextEditingController comPhoneController = TextEditingController();
  TextEditingController comEmailController = TextEditingController();
  TextEditingController comPasswordController = TextEditingController();
  TextEditingController comCityController = TextEditingController();
  TextEditingController comAddressController = TextEditingController();
  TextEditingController comIndustryController = TextEditingController();
  TextEditingController comCountryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _termsAndCondChecked = false;
    var provider = Provider.of<UserProvider>(context);

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
                                        child: Image.asset(
                                            "assets/img_holder.png"),
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
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.yellow,
                                            ),
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
                      controller: comNameController,
                      txtInputType: TextInputType.text,
                      hintText: comName,
                      prefixIcon: const Icon(FontAwesomeIcons.mountainCity),
                      isRequired: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: comPhoneController,
                      txtInputType: TextInputType.number,
                      hintText: comPhone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      isRequired: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        controller: comEmailController,
                        txtInputType: TextInputType.emailAddress,
                        hintText: comEmail,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.alternate_email)),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        controller: comPasswordController,
                        txtInputType: TextInputType.visiblePassword,
                        hintText: tPassTxt,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.fingerprint)),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CText(
                        text: comAddresses,
                        decorations: TextDecorations(
                            fontSize: 16, family: 'Roboto-Light'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                        controller: comAddressController,
                        txtInputType: TextInputType.text,
                        hintText: comAddress,
                        prefixIcon: const Icon(FontAwesomeIcons.addressBook)),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: comCountryController,
                      txtInputType: TextInputType.text,
                      hintText: comCountry,
                      prefixIcon: const Icon(Icons.flag),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CText(
                        text: descriptionDetails,
                        decorations: TextDecorations(
                            fontSize: 16, family: 'Roboto-Light'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      minLines: 1,
                      maxLines: 13,
                      controller: descriptionController,
                      txtInputType: TextInputType.text,
                      hintText: comCountry,
                      prefixIcon: const Icon(Icons.flag),
                    ),
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
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CButton(
                          onClicked: () async {
                            var companyData = User(
                                type: type,
                                description: descriptionController.text,
                                address: comAddressController.text,
                                username: comNameController.text,
                                email: comEmailController.text,
                                password: comPasswordController.text,
                                regionOrCity: comCountryController.text,
                                mobile: int.parse(
                                  comPhoneController.text,
                                ));

                            provider.createUser(companyData).whenComplete(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => Login()));
                            });
                          },
                          width: double.maxFinite,
                          padding: 14,
                          radius: 4,
                          backgroundColor: colors['secondary'],
                          widget: Center(
                            child: provider.isSaving
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : CText(
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
