import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/views/components/user_profile.dart';
import 'package:job_finder/views/pages/applied_page.dart';
import 'package:job_finder/views/pages/book_marks_page.dart';
import 'package:job_finder/views/pages/home_view.dart';

///Creates list of menus that routes different pages or different screens
final List<Map<String, dynamic>> menus = [
  {
    "menuIcon": FaIcon(FontAwesomeIcons.house),
    "menuTitle": "Home",
    "trailing": FaIcon(FontAwesomeIcons.angleRight),
    "onClick": (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), // Navigate to ProfilePage
      );
    }
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.bookJournalWhills),
    "menuTitle": "Jobs",
    "trailing": FaIcon(FontAwesomeIcons.angleRight)
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.suitcase),
    "menuTitle": "Applied",
    "trailing": FaIcon(FontAwesomeIcons.angleRight),
    "onClick": (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const AppliedPage()), // Navigate to ProfilePage
      );
    }
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.bookmark),
    "menuTitle": "Book Marks",
    "trailing": FaIcon(FontAwesomeIcons.angleRight),
    "onClick": (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const BookMarksPage()), // Navigate to ProfilePage
      );
    }
  },
  {
    "menuIcon": FaIcon(FontAwesomeIcons.user),
    "menuTitle": "Profile",
    "trailing": FaIcon(FontAwesomeIcons.angleRight),
    "onClick": (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const UserProfile()), // Navigate to ProfilePage
      );
    }
  }
];
