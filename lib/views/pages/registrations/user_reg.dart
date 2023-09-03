import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/mixins/messages.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/custom_text_field.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_image.dart';
import 'package:job_finder/util/text.dart';
import 'package:http/http.dart' as http;
import '../../../consts/colors.dart';
import '../login_page.dart';

class UserReg extends StatelessWidget with Messages {
  UserReg({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String type = "User";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> registerUser(String fullName, String email, String password,
       String phone,String city) async {
    final url = Uri.parse('http://192.168.100.7:9999/api/register');

    // Create a Map to represent your request body
    final Map<String, dynamic> requestBody = {
      "username": fullName,
      "email": email,
      "password": password,
      "type": type,
      "phone": phone,
      "city": city,
    };

    // Encode the request body as JSON
    final String jsonBody = jsonEncode(requestBody);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonBody,
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print("User with the userName: ${fullName} is registered successfully.");
    } else {
      print("Registration failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _termsAndCondChecked = false;
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
              CustomTextField(
                controller: fullNameController,
                txtInputType: TextInputType.text,
                hintText: signUpFullNameTft,
                prefixIcon: const Icon(Icons.person_outline_rounded),
                // validator: (value) {
                //   if(value == null || value.isNotEmpty) {
                //     return 'This field is required.';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: emailController,
                txtInputType: TextInputType.emailAddress,
                hintText: tEmail,
                prefixIcon: const Icon(Icons.email_outlined),
                // validator: (value) {
                //   if(value == null || value.isNotEmpty) {
                //     return 'This field is required.';
                //   }
                //   return null;
                // },
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
              CustomTextField(
                controller: passwordController,
                txtInputType: TextInputType.visiblePassword,
                hintText: tPassTxt,
                prefixIcon: const Icon(Icons.fingerprint),
                // validator: (value) {
                //   if(value == null || value.isNotEmpty) {
                //     return 'This field is required.';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: phoneController,
                txtInputType: TextInputType.phone,
                hintText: tPhone,
                prefixIcon: const Icon(Icons.mobile_friendly),
                // validator: (value) {
                //   if(value == null || value.isNotEmpty) {
                //     return 'This field is required.';
                //   }

                //   return null;
                // },
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: cityController,
                txtInputType: TextInputType.text,
                hintText: tSelectCity,
                prefixIcon: const Icon(Icons.location_city),
                // validator: (value) {
                //   if(value == null || value.isNotEmpty) {
                //     return 'This field is required.';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(
                height: 12,
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
                        const TextSpan(
                            text: signUpConditionTxt,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Light',
                                color: Colors.black)),
                        const WidgetSpan(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CButton(
                    onClicked: () async {
                      registerUser(
                        fullNameController.text,
                        emailController.text,
                        passwordController.text,
                        phoneController.text,
                        cityController.text
                      );
                    },
                    width: double.maxFinite,
                    padding: 14,
                    radius: 4,
                    backgroundColor: colors['primary'],
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
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  children: [
                    Center(
                        child: CText(
                      text: "OR",
                      decorations: TextDecorations(fontSize: 20),
                    )),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: IconImage(
                            iconImagePath: "assets/google.png",
                            width: 40,
                            backgroundColor: Colors.transparent,
                          ),
                          label: CText(
                            text: signUpWithGoogle,
                            decorations: TextDecorations(
                              fontSize: 18,
                            ),
                          )),
                    ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
