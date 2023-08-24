import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Color? color;
  final String imagePath;
  final double? paddingAll;
  const ProfileImage({
    super.key,
    required this.imagePath,
    this.color,
    this.paddingAll
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: color??Colors.white,
      child: Padding(
        padding:  EdgeInsets.all(paddingAll??8.0),
        child: Image.asset(imagePath),
      ),
    );
  }
}