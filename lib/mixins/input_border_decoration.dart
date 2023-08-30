import 'package:flutter/material.dart';

import '../consts/colors.dart';

mixin TextFieldBorderDecorator{
 OutlineInputBorder decorateBorder({double? radius, double? width,required Color color}){
   return  OutlineInputBorder(
       borderRadius: BorderRadius.circular(13),
       borderSide: BorderSide(
           color: color,
           width: width??2,
           style: BorderStyle.solid
       )
   );
 }
}