import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/mixins/bottom_navigation_mixin.dart';
import 'package:job_finder/modals/jobs/applied_jobs.dart';
import 'package:job_finder/modals/jobs/job_modal.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/filter_dailog.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_image.dart';
import 'package:job_finder/util/icon_text.dart';
import 'package:job_finder/util/profile.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/applied_job_card.dart';
import 'package:job_finder/views/components/job_card.dart';

import '../../consts/colors.dart';

class AppliedPage extends StatefulWidget{
  const AppliedPage({super.key});

  @override
  State<AppliedPage> createState() => _AppliedPageState();
}

class _AppliedPageState extends State<AppliedPage> with BottomNavigationBarMixin {
  @override
  Widget build(BuildContext context) {
    List<AppliedJobs> appliedJobs = [
      AppliedJobs(
          companyLogo: "assets/google.png",
          company: "Google, Inc",
          jobTitle: "Agency Lead",
          timePosted: "2day ago"),
      AppliedJobs(
          companyLogo: "assets/hilal.png",
          company: "Hilal, Inc",
          jobTitle: "Database Admin",
          timePosted: "4days ago",
          status: "Rejected"),
      AppliedJobs(
          companyLogo: "assets/afro.png",
          company: "Afro, Inc",
          jobTitle: "Web Developer",
          timePosted: "4days ago",
          status: "Rejected"),
      AppliedJobs(
          companyLogo: "assets/google.png",
          company: "Google, Inc",
          jobTitle: "Mobile App Developer",
          timePosted: "4days ago",
          status: "Sent"),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileImage(
                        radius: 30,
                        asBackgroundImage: true,
                        imagePath: "assets/me.jpeg"),
                    CText(
                      text: "Applied Jobs",
                      decorations: TextDecorations(
                          color: colors['secondary'] as Color,
                          fontSize: 20,
                          family: "Poppins SemiBold"),
                    ),
                    CButton(
                        onClicked: () async{
                         var data=await showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                    title: IconText(
                                      icon: FontAwesomeIcons.filter,
                                      iconLabel: "Choose Filter",
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor:
                                        colors['white-color'] as Color,
                                    content: FilterDialog(),
                                scrollable: true,);
                              });

                         print(data);
                        },
                        width: 45,
                        radius: 50,
                        backgroundColor: colors['primary']!.withOpacity(0.2),
                        widget: Center(child: FaIcon(FontAwesomeIcons.filter)))
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ListView.builder(
                  itemCount: appliedJobs.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (_, index) =>
                      AppliedJobCard(job: appliedJobs[index])),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
