import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/mixins/no_data_found_error.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_image.dart';
import 'package:job_finder/util/icon_text.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/banner_top.dart';

import '../../consts/menus_list.dart';
import '../../mixins/listview_builder_job_card.dart';
import '../../modals/jobs/job_modal.dart';
import '../../util/buton.dart';
import '../../util/categories.dart';
import '../../util/profile.dart';
import '../components/job_card.dart';
import '../components/job_header.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../components/login_mode_profile.dart';

class Home extends StatelessWidget with BuildListViewJobCard {
  const Home({super.key});
  static var categories = [
    "Software Engineering",
    "UI/UX Designer",
    "Database Admin",
    "Graphic Designer",
    "Analytical",
    "Help Desk"
  ];
  static List<Job> jobs = [
    Job(
        jobTitle: "Agency Business Lead",
        corporation: "Google, Inc",
        companyLogoPath: "assets/google.png",
        jobDescription:
            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying",
        numberOfApplicants: 19,
        timePosted:
            timeago.format(DateTime.now().subtract(Duration(minutes: 6)))),
    Job(
        jobTitle: "Software Tester",
        corporation: "Afro Tech",
        companyLogoPath: "assets/afro.png",
        jobDescription:
            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate",
        numberOfApplicants: 100,
        timePosted: timeago.format(DateTime.now().subtract(Duration(days: 2)))),


    Job(jobTitle: "Social Media Marketer", corporation: "Hilaal, Inc", companyLogoPath: "assets/hilal.png",
        jobDescription: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate",
        numberOfApplicants: 300 ,
        softSkills: ["Design","Teaching","Blender","Copy Writing","Canva"],
        about: "We are seeking a talented Social Media Marketer to elevate our brand's online presence and engagement. In this role, you'll be responsible for crafting captivating content, managing social media platforms, and driving meaningful interactions with our target audience. Your creative approach and strategic thinking will play a pivotal role in expanding our brand's influence in the digital landscape. As a Social Media Marketer, you'll have the exciting opportunity to develop and implement dynamic social media strategies across various platforms. Your eye for engaging visuals and ability to craft compelling captions will help us effectively convey our brand's message and values. By staying up-to-date with the latest social media trends, you'll ensure our content remains fresh and relevant. Join our team and shape the way our audience perceives and engages with our brand on social media.",
        timePosted: timeago.format(DateTime.now().subtract(Duration(days: 2)))),
    Job(
        jobTitle: "Web Developer",
        corporation: "Tombal ICT",
        companyLogoPath: "assets/hilal.png",
        jobDescription:
            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate",
        numberOfApplicants: 300,

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
          IconButton(onPressed: () {
            showSearch(context: context, delegate: JobSearchDelegate(jobList: jobs));
          }, icon: Icon(Icons.search)),
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
      drawer: Drawer(
        backgroundColor: Colors.white,
        width: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 280,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    color: colors['primary']!.withOpacity(0.8) as Color,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(80))),
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                child: LoginModeProfile(
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  itemCount: menus.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_,index){
                    var menu=menus[index];
                      return ListTile(
                        onTap: menu['onClick'] != null
                          ? ()=> menu['onClick'](context)
                          : null,
                        iconColor: colors['primary']!.withOpacity(0.7),
                        leading: menu['menuIcon'],
                        title: CText(text: menu['menuTitle'],
                        decorations: TextDecorations(
                          fontSize: 18,
                          family: "Poppins Medium"
                        ),),
                        trailing: menu['trailing'],
                      );
                    })

              ],
            )
          ],
        ),
      ),
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
            buildJobListView(context,jobs)
          ],
        ),
      ),
    );
  }

}



class JobSearchDelegate extends SearchDelegate with BuildListViewJobCard,NoDataErrorMixin{
  final List<Job> jobList;
  JobSearchDelegate({required this.jobList}):super(
  keyboardType: TextInputType.text
);


@override
  String? get searchFieldLabel => "Search Job...";

  @override
  TextStyle? get searchFieldStyle => TextStyle(
    color: colors['secondary'],
    fontFamily: "Poppins Medium",
    fontSize: 18
  );

  @override
  List<Widget>? buildActions(BuildContext context) {

    return[
      IconButton(onPressed: (){
        query='';
      }, icon: FaIcon(FontAwesomeIcons.xmark))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: (){
     close(context, null);
   }, icon: FaIcon(FontAwesomeIcons.angleLeft));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildJobListView(context, jobList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Job> matchedResults=[];
    for(var item in jobList) {
      if(item.jobTitle.toLowerCase().contains(query.toLowerCase())) {
        matchedResults.add(item);
      }
    }
    if(matchedResults.isNotEmpty) {
      return buildJobListView(context, matchedResults);
    }

    return noDataError(context,close);
  }



}





