import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/mixins/input_border_decoration.dart';
import '../mixins/messages.dart';

class CustomTextField extends StatelessWidget
    with TextFieldBorderDecorator, Messages {
  const CustomTextField({
    Key? key,
    required this.txtInputType,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconFunction,
    this.obscureTxt,
    this.isHidenTxt,
    this.showOrHidePassword,
    this.initialValue,
    required this.controller,
    this.validator,
    this.maxLines,
    this.minLines,
    this.isRequired = false,
  });

  final TextInputType txtInputType;
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final void Function()? suffixIconFunction;
  final bool? obscureTxt;
  final bool? isHidenTxt;
  final VoidCallback? showOrHidePassword;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool? isRequired;
  final int? maxLines, minLines;
  final String? initialValue;

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
        initialValue: initialValue,
        controller: controller,
        keyboardType: txtInputType,
        textAlign: TextAlign.start,
        obscureText: obscureTxt ?? false,
        maxLines: maxLines,
        minLines: minLines,
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
              : IconButton(
                  onPressed: suffixIconFunction,
                  icon: suffixIcon ?? SizedBox.shrink()),
          prefixIcon: prefixIcon,
        ),
        validator: validator != null
            ? (value) {
                if (isRequired! && (value == null || value.isEmpty)) {
                  return 'This field is required';
                }
                if (validator!(value) != null) {
                  return 'Invalid input';
                }
                return null;
              }
            : null,
      ),
    );
  }
}
