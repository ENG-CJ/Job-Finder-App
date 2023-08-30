import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/modals/jobs/job_modal.dart';

import '../../consts/colors.dart';
import '../../consts/texts.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/icon_text.dart';
import '../../util/text.dart';
import 'job_details.dart';
import 'job_header.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  JobDetails(job: job,)),
        );
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 16, top: 10, right: 16),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFa197c4).withOpacity(1),
                offset: const Offset(-1, 1),
                blurRadius: 16,
                spreadRadius: -10,
              ),
            ],
            color: colors['white-color'],
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobHeader(
              company: job.corporation,
              jobTitle: job.jobTitle,
              logo: job.companyLogoPath,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                child: CText(
                    decorations:
                        TextDecorations(height: 1.3, family: "Poppins Light"),
                    text: job.jobDescription)),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 8, right: 8),
              child: Row(
                children: [
                  IconText(
                    icon: FontAwesomeIcons.clock,
                    iconLabel: job.timePosted,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  IconText(
                    icon: FontAwesomeIcons.users,
                    iconLabel: '${job.numberOfApplicants} Applicants',
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
