import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
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
import '../../../mixins/image_picker_resource.dart';
import '../../../util/buton.dart';
import '../login_page.dart';

class RegisterCompany extends StatefulWidget {
  RegisterCompany({super.key});

  @override
  State<RegisterCompany> createState() => _RegisterCompanyState();
}

class _RegisterCompanyState extends State<RegisterCompany>
    with Messages, ImagePickerResource {
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
  File? imagePath;

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
                                  height: 90,
                                  width: 100,
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 20),
                                  decoration: BoxDecoration(
                                      // color: Colors.red
                                      ),
                                  child: Stack(
                                    children: [
                                      imagePath != null
                                          ? CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                                  FileImage(imagePath!))
                                          : CircleAvatar(
                                              radius: 40,
                                              backgroundImage: AssetImage(
                                                  "assets/img_holder.png")),
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
                                            onPressed: () async {
                                              var image =
                                                  await getImagePicked();
                                              if (image != null) {
                                                setState(() {
                                                  imagePath = image;
                                                });
                                              }
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      controller: comPhoneController,
                      txtInputType: TextInputType.number,
                      hintText: comPhone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        controller: comEmailController,
                        txtInputType: TextInputType.emailAddress,
                        hintText: comEmail,
                        prefixIcon: const Icon(Icons.alternate_email)),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        controller: comPasswordController,
                        txtInputType: TextInputType.visiblePassword,
                        hintText: tPassTxt,
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
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CButton(
                          onClicked: () async {
                            var companyData = User(
                                imageFile: imagePath,
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
                                                    builder: (context) =>
                                                        Login()));
                                          })
                                  ]),
                            )
                          ],
                        ),
                      ),
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
