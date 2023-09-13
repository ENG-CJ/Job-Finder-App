import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../consts/colors.dart';

mixin BottomNavigationBarMixin {
  Widget curvedNavigationBar(int currentIndex,
      {void Function(int)? onClickIndex}) {
    return CurvedNavigationBar(
      index: currentIndex,
      onTap: onClickIndex,
      backgroundColor: colors['white-color'] as Color,
      color: colors['primary'] as Color,
      animationCurve: Curves.ease,
      items: [
        FaIcon(
          FontAwesomeIcons.house,
          color: Colors.white,
        ),
        FaIcon(
          FontAwesomeIcons.suitcase,
          color: Colors.white,
        ),
        FaIcon(
          FontAwesomeIcons.bookmark,
          color: Colors.white,
        ),
      ],
    );
  }
}
