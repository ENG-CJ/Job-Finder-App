import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/mixins/input_border_decoration.dart';
import 'package:job_finder/mixins/messages.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/services/local/local_storage.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/pages/home_page.dart';
import 'package:job_finder/views/pages/user_type_page.dart';
import 'package:provider/provider.dart';

import '../dashboard/screens/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TextFieldBorderDecorator, Messages {
  bool _isHiddenText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: 200,
            left: 10,
            child: SizedBox(
              child: Image.asset(
                "assets/lock.png",
                width: 180,
                opacity: AlwaysStoppedAnimation(0.6),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 280),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFe7e1ec).withOpacity(1),
                            offset: Offset(2, -1),
                            blurRadius: 100,
                            spreadRadius: 3,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, left: 20),
                      child: _buildLoginContent(context),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: -10,
            child: SizedBox(
              child: Hero(
                tag: "image-1",
                child: Image.asset(
                  "assets/login-2.png",
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _showOrHidePassword() => setState(() {
        _isHiddenText = !_isHiddenText;
      });
  var email = TextEditingController();
  var pass = TextEditingController();
  Widget _buildLoginContent(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            text: "LOGIN",
            decorations: TextDecorations(
              fontSize: 25,
              family: "Poppins Bold",
              color: colors['primary'] as Color,
            ),
          ),
          CText(
            text: "Welcome! Login Your Valid Account",
            decorations: TextDecorations(
                color: colors['secondary'] as Color, family: "Poppins Light"),
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          CText(
            text: "Email *",
            decorations: TextDecorations(
                color: colors['secondary'] as Color, fontSize: 19),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  suffixIconColor: colors['primary']!.withOpacity(0.7) as Color,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FaIcon(FontAwesomeIcons.envelope),
                  ),
                  hintText: "example@gmail.com",
                  border: OutlineInputBorder(),
                  enabledBorder: decorateBorder(
                      radius: 13,
                      color: colors['secondary']!.withOpacity(0.7),
                      width: 1),
                  focusedBorder: decorateBorder(
                      radius: 13, color: colors['primary'] as Color, width: 2),
                  errorBorder: decorateBorder(
                      radius: 13,
                      color: colors['error-color'] as Color,
                      width: 2)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CText(
            text: "Password *",
            decorations: TextDecorations(
                color: colors['secondary'] as Color, fontSize: 19),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: TextFormField(
              controller: pass,
              obscureText: _isHiddenText,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIconColor: colors['primary']!.withOpacity(0.7) as Color,
                  suffixIcon: _isHiddenText
                      ? IconButton(
                          icon: FaIcon(FontAwesomeIcons.eye),
                          onPressed: _showOrHidePassword,
                        )
                      : IconButton(
                          icon: FaIcon(FontAwesomeIcons.eyeSlash),
                          onPressed: _showOrHidePassword,
                        ),
                  hintText: "Your Passcode",
                  border: OutlineInputBorder(),
                  enabledBorder: decorateBorder(
                      radius: 13,
                      color: colors['secondary']!.withOpacity(0.7),
                      width: 1),
                  focusedBorder: decorateBorder(
                      radius: 13, color: colors['primary'] as Color, width: 2),
                  errorBorder: decorateBorder(
                      radius: 13,
                      color: colors['error-color'] as Color,
                      width: 2)),
            ),
          ),
          Row(children: [
            CText(text: "Don't Have Account? "),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserTypePage()),
                  );
                },
                child: CText(text: "Signup"))
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: CButton(
                onClicked: () async {
                  provider.login({
                    "email": email.text,
                    "password": pass.text,
                  }).whenComplete(() {
                    if (provider.hasError) {
                      showDialog(
                          context: context,
                          builder: (_) => showError(
                              context, provider.description, provider.error));
                    } else {
                      if (provider.user == null) {
                        showDialog(
                            context: context,
                            builder: (_) => showError(
                                  context,
                                  "Email or Password is Incorrect, Please Provide Valid Account",
                                ));
                      } else {
                        LocalStorageSharedPref().storeUserDetails({
                          "user_id": provider.user!.id,
                          "type": provider.user!.type,
                          "email": provider.user!.email,
                          "username": provider.user!.username,
                        }).whenComplete(() {
                          if (provider.user!.type == "User") {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => Home()),
                                (route) => false);
                          } else {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => Dashboard()),
                                (route) => false);
                          }
                        });
                      }
                    }
                  });
                },
                width: double.maxFinite,
                padding: 20,
                radius: 20,
                backgroundColor: colors['primary'] as Color,
                widget: Center(
                    child: provider.isSaving
                        ? CircularProgressIndicator()
                        : CText(
                            text: "LOGIN",
                            decorations: TextDecorations(
                                fontSize: 18,
                                family: "Poppins SemiBold",
                                color: Colors.white),
                          ))),
          )
        ],
      ),
    );
  }
}
