import 'package:flutter/cupertino.dart';

import '../../consts/colors.dart';
import '../../mixins/listview_builder_job_card.dart';
import '../../modals/jobs/job_modal.dart';
import '../../util/categories.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/text.dart';
import '../components/banner_top.dart';
import 'package:timeago/timeago.dart' as timeago;
class HomePage extends StatelessWidget with BuildListViewJobCard {
  const HomePage({super.key});
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
      timePosted: '3days',
    ),
    Job(
        jobTitle: "Social Media Marketer",
        corporation: "Hilaal, Inc",
        companyLogoPath: "assets/hilal.png",
        jobDescription:
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate",
        numberOfApplicants: 300,

        timePosted: timeago.format(DateTime.now().subtract(Duration(days: 6))))
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
