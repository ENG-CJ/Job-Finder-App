import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:job_finder/consts/colors.dart';

class TextDecorations{
  String family;
  double height,fontSize;
  FontWeight weight;
  Color color;

  TextDecorations({
    this.weight=FontWeight.normal,
    this.height=0,
    this.fontSize=14,
    this.color=Colors.black,
    this.family="Roboto Regular",
});

}