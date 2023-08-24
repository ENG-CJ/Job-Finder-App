import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_text.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/banner_top.dart';

import '../../modals/jobs/job_modal.dart';
import '../../util/categories.dart';
import '../components/job_card.dart';
import '../components/job_header.dart';
import 'package:timeago/timeago.dart' as timeago;


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
  static List<Job> jobs=[
    Job(jobTitle: "Agency Business Lead", corporation: "Google, Inc", companyLogoPath: "assets/google.png",
        jobDescription: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying",
        numberOfApplicants: 19 ,
        timePosted: timeago.format(DateTime.now().subtract(Duration(minutes: 6)))),

    Job(jobTitle: "Software Tester", corporation: "Afro Tech", companyLogoPath: "assets/afro.png",
        jobDescription: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate",
        numberOfApplicants: 100 ,
        timePosted: timeago.format(DateTime.now().subtract(Duration(days: 2)))),

    Job(jobTitle: "Social Media Marketer", corporation: "Hilaal, Inc", companyLogoPath: "assets/hilal.png",
        jobDescription: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate",
        numberOfApplicants: 300 ,
        timePosted: timeago.format(DateTime.now().subtract(Duration(days: 6))))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
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
          FaIcon(
            FontAwesomeIcons.user,
            color: Colors.white,
          ),
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
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
                    family: "Poppins SemiBold"),
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 16),
              child: CText(
                text: "Poppular Jobs",
                decorations: TextDecorations(
                    color: colors['secondary'] as Color,
                    fontSize: 22,
                    family: "Poppins SemiBold"),
              ),
            ),
            ListView.builder(
              itemCount: jobs.length,
              shrinkWrap: true,
                primary: false,
                itemBuilder: (_,index){
                return JobCard(job: jobs[index]);
                })
          ],
        ),
      ),
    );
  }
}


