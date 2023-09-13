import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Color? color;
  final String imagePath;
  final File? imageFile;
  final double? paddingAll;
  final bool asBackgroundImage;
  final bool fromNetwork;
  final bool fromFile;
  final double radius;
  const ProfileImage(
      {super.key,
      required this.imagePath,
      this.imageFile,
      this.color,
      this.paddingAll,
      this.asBackgroundImage = false,
      this.fromNetwork = false,
      this.fromFile = false,
      this.radius = 40});

  @override
  Widget build(BuildContext context) {
    return !asBackgroundImage
        ? CircleAvatar(
            radius: radius,
            backgroundColor: color ?? Colors.white,
            child: Padding(
              padding: EdgeInsets.all(paddingAll ?? 8.0),
              child: Image.asset(
                imagePath,
                height: 120,
                width: 120,
              ),
            ),
          )
        : fromFile
            ? CircleAvatar(
                radius: radius,
                backgroundColor: color ?? Colors.white,
                backgroundImage: FileImage(imageFile!),
              )
            : !fromNetwork
                ? CircleAvatar(
                    radius: radius,
                    backgroundColor: color ?? Colors.white,
                    backgroundImage: AssetImage(imagePath),
                  )
                : CircleAvatar(
                    radius: radius,
                    backgroundColor: color ?? Colors.white,
                    backgroundImage: NetworkImage(imagePath),
                  );
  }
}
