import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Color? color;
  final String imagePath;
  final double? paddingAll;
  final bool asBackgroundImage;
  final double radius;
  const ProfileImage({
    super.key,
    required this.imagePath,
    this.color,
    this.paddingAll,
    this.asBackgroundImage=false,
    this.radius=40
  });

  @override
  Widget build(BuildContext context) {
    return !asBackgroundImage?  CircleAvatar(
      radius: radius,
      backgroundColor: color??Colors.white,

      child: Padding(
        padding: EdgeInsets.all(paddingAll ?? 8.0),
        child: Image.asset(
          imagePath, height: 120,width: 120,
        ),
      ),
    )
    :
    CircleAvatar(
      radius: radius,
      backgroundColor: color??Colors.white,
      backgroundImage: AssetImage(imagePath),
    )
    ;
  }
}
