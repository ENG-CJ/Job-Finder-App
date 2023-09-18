import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/services/local/book_marks.dart';

import '../../consts/colors.dart';
import '../../mixins/messages.dart';
import '../../modals/jobs/job_modal_latest.dart';
import '../../util/helpers/text_helper.dart';
import '../../util/icon_text.dart';
import '../../util/text.dart';
import 'job_details.dart';
import 'job_header.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:animated_snack_bar/animated_snack_bar.dart';

class JobCard extends StatelessWidget with Messages {
  final JobOnUserScreen job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JobDetails(
                    job: job,
                  )),
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
              onClickIcon: () async {
                var bookmark = Bookmarks(
                    key: job.id,
                    jobTitle: job.jobTitle,
                    company: job.company,
                    jobDescription: job.descripton);
                bookmark.hasData(job.id).then((value) {
                  if (value) {
                    showDialog(
                        context: context,
                        builder: (_) => showError(
                            context,
                            "Already Bookmarked!!, Click Bookmark view to remove if you want",
                            "BookMarks"));
                  } else {
                    bookmark.addBookmarks(bookmark).whenComplete(() {
                      AnimatedSnackBar.material("Added Bookmark",
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                              duration: Duration(seconds: 8),
                              type: AnimatedSnackBarType.success)
                          .show(context);
                    });
                  }
                });
              },
              company: job.company,
              jobTitle: job.jobTitle,
              logo: job.profile,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                child: CText(
                    decorations:
                        TextDecorations(height: 1.3, family: "Poppins Light"),
                    text: job.descripton)),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 8, right: 8),
              child: Row(
                children: [
                  IconText(
                    icon: FontAwesomeIcons.clock,
                    iconLabel: timeago.format(job.posted),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  IconText(
                    icon: FontAwesomeIcons.users,
                    iconLabel: '${job.applicants} Applicants',
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
