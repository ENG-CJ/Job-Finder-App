import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/mixins/input_border_decoration.dart';
import '../../consts/colors.dart';
import '../../mixins/messages.dart';
class CustomTextField extends StatelessWidget
    with TextFieldBorderDecorator, Messages {
  const CustomTextField({
    Key? key,
    required this.txtInputType,
    required this.hintText,
    required this.prefixIcon,
    this.obscureTxt,
    this.isHidenTxt,
    this.showOrHidePassword,
  });

  final TextInputType txtInputType;
  final String hintText;
  final Icon prefixIcon;
  final bool? obscureTxt;
  final bool? isHidenTxt;
  final VoidCallback? showOrHidePassword;

  @override
  Widget build(BuildContext context) {
    bool isPasswordType = txtInputType == TextInputType.visiblePassword;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        keyboardType: txtInputType,
        textAlign: TextAlign.start,
        obscureText: obscureTxt ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 14, 10, 10),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,

          suffixIcon: isPasswordType
              ? (isHidenTxt ?? false
              ? IconButton(
            icon: FaIcon(FontAwesomeIcons.eye),
            onPressed: showOrHidePassword,
          )
              : IconButton(
            icon: FaIcon(FontAwesomeIcons.eyeSlash),
            onPressed: showOrHidePassword,
          ))
              : null,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
