import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/mixins/no_data_found_error.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';
import 'package:job_finder/views/pages/job_based_category.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../consts/colors.dart';
import '../../mixins/listview_builder_job_card.dart';
import '../../modals/jobs/job_modal.dart';
import '../../modals/jobs/job_modal_latest.dart';
import '../../util/categories.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/text.dart';
import '../components/banner_top.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatelessWidget
    with BuildListViewJobCard, NoDataErrorMixin {
  HomePage({super.key});

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
    Job(
      jobTitle: "Social Media Marketer",
      corporation: "Hilaal, Inc",
      companyLogoPath: "assets/hilal.png",
      jobDescription:
          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate",
      numberOfApplicants: 300,
      softSkills: ["Design", "Teaching", "Blender", "Copy Writing", "Canva"],
      about:
          "We are seeking a talented Social Media Marketer to elevate our brand's online presence and engagement. In this role, you'll be responsible for crafting captivating content, managing social media platforms, and driving meaningful interactions with our target audience. Your creative approach and strategic thinking will play a pivotal role in expanding our brand's influence in the digital landscape. As a Social Media Marketer, you'll have the exciting opportunity to develop and implement dynamic social media strategies across various platforms. Your eye for engaging visuals and ability to craft compelling captions will help us effectively convey our brand's message and values. By staying up-to-date with the latest social media trends, you'll ensure our content remains fresh and relevant. Join our team and shape the way our audience perceives and engages with our brand on social media.",
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

  static var categories = [
    "Software Engineering",
    "UI/UX Designer",
    "Database Admin",
    "Graphic Designer",
    "Analytical",
    "Help Desk"
  ];

  Widget _buildWidget(BuildContext context, List<JobOnUserScreen> jobs) {
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
                      child: Consumer<JobProvider>(builder: (_, data, child) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) {
                            return Categories(
                                onTap: () {
                                  Provider.of<JobProvider>(context,
                                          listen: false)
                                      .getJobsBasedOnCategories(
                                          data.categories[index].category)
                                      .whenComplete(() {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => JobBasedCategory(
                                                  category: data
                                                      .categories[index]
                                                      .category,
                                                )));
                                  });
                                },
                                categoryName: data.categories[index].category);
                          },
                          separatorBuilder: (_, index) => SizedBox(
                            width: 5,
                          ),
                          itemCount: data.categories.length,
                        );
                      }))
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
          jobs.length <= 0
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 70, left: 10, right: 10, bottom: 20),
                  child: noDataError(context, "Reload", "No Jobs Available",
                      "No Jobs Were Posted, Click Reload To Reflect if there any jobs!",
                      (context, result) {
                    Provider.of<JobProvider>(context, listen: false)
                        .getAllJobs();
                  }),
                )
              : LiquidPullToRefresh(
                  onRefresh: () async {
                    Provider.of<JobProvider>(context, listen: false)
                        .getAllJobs();
                  },
                  child: buildJobListView(context, jobs))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(builder: (_, data, child) {
      return data.isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: colors['primary'] as Color, size: 70),
            )
          : data.hasError
              ? noDataError(
                  context, "Retry", "Something Went Wrong", data.error,
                  (context, result) {
                  Provider.of<JobProvider>(context, listen: false).getAllJobs();
                })
              : _buildWidget(context, data.allJobs);
    });
  }
}
