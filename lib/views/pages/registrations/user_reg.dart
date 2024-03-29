import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/mixins/messages.dart';
import 'package:job_finder/modals/users/user.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/custom_text_field.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:provider/provider.dart';
import '../../../consts/colors.dart';
import '../login_page.dart';

class UserReg extends StatefulWidget with Messages {
  UserReg({super.key});

  @override
  State<UserReg> createState() => _UserRegState();
}

class _UserRegState extends State<UserReg> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String type = "User";

  final GlobalKey<FormState> fullNameFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> cityFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  void clearTxtField() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    cityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Top Title Texts */
              Container(
                  margin: const EdgeInsets.only(top: 50, left: 10),
                  child: CText(
                    text: signUpTxt,
                    decorations: TextDecorations(
                        fontSize: 26,
                        family: 'Roboto-Bold',
                        weight: FontWeight.bold,
                        color: Colors.black),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  child: CText(
                    text: welcomeTxt,
                    decorations: TextDecorations(
                        fontSize: 16,
                        family: 'Poppins-Light',
                        weight: FontWeight.normal),
                  )),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: fullNameFormKey,
                child: CustomTextField(
                  controller: fullNameController,
                  txtInputType: TextInputType.text,
                  hintText: signUpFullNameTft,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9_]{3,16}$').hasMatch(value)) {
                      return 'Invalid username!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: emailFormKey,
                child: CustomTextField(
                  controller: emailController,
                  txtInputType: TextInputType.emailAddress,
                  hintText: tEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    if (!RegExp(r'^[\W-\.]+@([\W-]+\.)+[\W]{2,4}$')
                        .hasMatch(value)) {
                      return 'Invalid username!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: passwordFormKey,
                child: CustomTextField(
                  controller: passwordController,
                  txtInputType: TextInputType.visiblePassword,
                  hintText: tPassTxt,
                  prefixIcon: const Icon(Icons.fingerprint),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    if (value.length != 6) {
                      return 'Password length must be 6 and above.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: phoneFormKey,
                child: CustomTextField(
                  controller: phoneController,
                  txtInputType: TextInputType.phone,
                  hintText: tPhone,
                  prefixIcon: const Icon(Icons.mobile_friendly),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9_]{3,16}$').hasMatch(value)) {
                      return 'Invalid City Name!';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: cityFormKey,
                child: CustomTextField(
                  controller: cityController,
                  txtInputType: TextInputType.text,
                  hintText: tSelectCity,
                  prefixIcon: const Icon(Icons.location_city),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                minLines: 1,
                maxLines: 13,
                controller: descriptionController,
                txtInputType: TextInputType.text,
                hintText: "Profile Description (optional)",
                prefixIcon: const Icon(Icons.flag),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CButton(
                    onClicked: () async {
                      var user = User(
                          description: descriptionController.text,
                          username: fullNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          regionOrCity: cityController.text,
                          mobile: int.parse(phoneController.text));
                      provider.createUser(user).whenComplete(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      });
                    },
                    width: double.maxFinite,
                    padding: 14,
                    radius: 4,
                    backgroundColor: colors['primary'],
                    widget: Center(
                      child: provider.isSaving
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
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
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text.rich(
                        TextSpan(
                            text: signUpHaveAnAccountTxt.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14, fontFamily: "Roboto-Bold"),
                            children: [
                              TextSpan(
                                  text: signUpLoginTxt.toUpperCase(),
                                  style: TextStyle(
                                      color: colors['primary'],
                                      fontSize: 14,
                                      fontFamily: "Roboto-Bold"),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    })
                            ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
