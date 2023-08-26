import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

import '../../consts/colors.dart';
import '../../mixins/messages.dart';
import '../../modals/jobs/applied_jobs.dart';
import '../../modals/jobs/job_modal.dart';
import '../../util/icon_text.dart';
import 'job_header.dart';

class AppliedJobCard extends StatelessWidget with Messages {
  final  AppliedJobs job;
  const AppliedJobCard({super.key,required this.job});

  @override
  Widget build(BuildContext context) {
    return  Container(
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
            onClickIcon: ()async{
              await showDialog(context: context, builder: (_){
               return
               showConfirmation(
                   context, "Confirm To Delete This Repo Instead of Gardle? click yes or no", 
                   "Are You Sure",
               );
             });

            },
            icon: FontAwesomeIcons.minus,
            company: job.company,
            jobTitle: job.jobTitle,
            logo: job.companyLogo,
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconText(
                  icon: FontAwesomeIcons.clock,
                  iconLabel: job.timePosted,
                ),
                SizedBox(
                  width: 25,
                ),
              _buildStatusButton(context, job.status)

              ],
            ),
          ),
          // SizedBox(height: 10,),

        ],
      ),
    );
  }

  Widget _buildStatusButton(BuildContext context,String status){
    switch(status){
      case "Pending":
        return  CButton(
            backgroundColor: colors['orange-color']!.withOpacity(0.3),
            widget:
            Center(child: CText(text: job.status)));
      case "Rejected":
        return CButton(
            backgroundColor: colors['error-color']!.withOpacity(0.7),
            widget:
            Center(child: CText(text: job.status)));
      default:
        return  CButton(
            backgroundColor: colors['success-color']!.withOpacity(0.6),
            widget:
            Center(child: CText(text: job.status)));
    }

  }
}
