import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

import '../consts/user_profile_enum.dart';

class RadioListTileButton<Type> extends StatelessWidget {
  final bool isSelected;
  final Color? selectedTileTextColor;
  final MaterialStateProperty<Color?>? checkBoxColor;
  final Color? backgroundListTileColor;
  final Color? selectedTileBackgroundColor;
  final TextDecorations? decorations;
  final String radioLabel;
  final Type value;
  final void Function(Type?)? onChangedValue;
  final Type groupValue;
  const RadioListTileButton(
      {super.key,
        this.isSelected=false,
        this.checkBoxColor,
        this.selectedTileTextColor,
        this.selectedTileBackgroundColor,
        this.backgroundListTileColor,
      this.decorations,
      required this.radioLabel,
      required this.value,
      required this.groupValue,
      required this.onChangedValue});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        onChangedValue!(value);
      },
      selected: isSelected,
      tileColor: backgroundListTileColor?? Color(0xffD8D9DA),
      selectedTileColor: selectedTileBackgroundColor,
      selectedColor: selectedTileTextColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      leading: Radio<Type>(
        fillColor: checkBoxColor,
          value: value, onChanged: onChangedValue, groupValue: groupValue),
      title: CText(
        text: radioLabel,
        decorations: decorations,
      ),
    );
  }
}
