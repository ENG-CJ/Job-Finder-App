import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/text.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  var filters=[
    "Pending",
    "Rejected",
    "Sent"
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: filters.map((filterValue){
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 9
            ),
            child: CButton(
              onClicked: ()=>{
                Navigator.pop(context,filterValue)
              },
                radius: 6,
                width: double.maxFinite,widget: CText(text: filterValue.toString(),)),
          );
        }).toList()
      ),
    );
  }
}
