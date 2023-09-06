import 'package:flutter/material.dart';
import 'package:job_finder/util/text.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String? value;
  final Function(String?) onChange;
  const CustomDropdownMenu({super.key, this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      child: DropdownButton(
          underline: SizedBox(),
          dropdownColor: Colors.grey[300],
          style: TextStyle(color: Colors.black, fontSize: 18),
          iconSize: 40,
          elevation: 5,
          isExpanded: true,
          value: value,
          hint: CText(text: "Select Job Type"),
          items: [
            DropdownMenuItem(child: CText(text: "FullTime"), value: "FullTime"),
            DropdownMenuItem(
                child: CText(text: "Part Time"), value: "PartTime"),
          ],
          onChanged: onChange),
    );
  }
}
