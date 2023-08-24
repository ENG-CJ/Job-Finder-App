 import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///Creates list of menus that routes different pages or different screens
final  List<Map<String,dynamic>> menus=[
  {
    "menuIcon": FaIcon(FontAwesomeIcons.house),
    "menuTitle": "Home",
    "trailing": FaIcon(FontAwesomeIcons.angleRight),
    "onClick" : ()=> print('Hello Clciked From Map')
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.bookJournalWhills),
    "menuTitle": "Jobs",
    "trailing": FaIcon(FontAwesomeIcons.angleRight)
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.suitcase),
    "menuTitle": "Applied",
    "trailing": FaIcon(FontAwesomeIcons.angleRight)
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.bookmark),
    "menuTitle": "Book Marks",
    "trailing": FaIcon(FontAwesomeIcons.angleRight)
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.user),
    "menuTitle": "Profile",
    "trailing": FaIcon(FontAwesomeIcons.angleRight)
  }
];