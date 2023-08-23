import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/banner_top.dart';

import '../../util/categories.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static var categories = [
    "Software Engineering",
    "UI/UX Designer",
    "Database Admin",
    "Graphic Designer",
    "Analytical",
    "Help Desk"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors['white-color'],
        foregroundColor: colors['secondary'],
        centerTitle: true,
        title: CText(
          text: "Job Finder",
          decorations: TextDecorations(
              color: colors['secondary'] as Color,
              weight: FontWeight.bold,
              fontSize: 20),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: colors['white-color'] as Color,
        color: colors['primary'] as Color,
        animationCurve: Curves.ease,
        items: [

        FaIcon(FontAwesomeIcons.house,color: Colors.white,),
        FaIcon(FontAwesomeIcons.suitcase,color: Colors.white,),
        FaIcon(FontAwesomeIcons.bookmark,color: Colors.white,),
        FaIcon(FontAwesomeIcons.user,color: Colors.white,),

        ],
      ),
      drawer: Drawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBanner(),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: CText(
              text: "Categories",
              decorations: TextDecorations(
                color: colors['secondary'] as Color,
                fontSize: 22,
                weight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (_, index) {
                        return Categories(categoryName: categories[index]);
                      },
                      separatorBuilder: (_, index) => SizedBox(
                        width: 5,
                      ),
                      itemCount: categories.length,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
