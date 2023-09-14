import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/mixins/messages.dart';
import 'package:job_finder/modals/jobs/job_modal_latest.dart';
import 'package:job_finder/modals/jobs/requests.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';

import 'package:job_finder/services/local/local_storage.dart';
import 'package:provider/provider.dart';
import '../../consts/api_url.dart';
import '../../consts/texts.dart';
import '../../util/icon_image.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../util/text.dart';

class JobDetails extends StatefulWidget {
  final JobOnUserScreen job;

  const JobDetails({super.key, required this.job});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> with Messages {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          detailPgTitle,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins Light",
              color: colors['secondary']),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  Job Title  */
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 22),
              child: Text(
                widget.job.jobTitle,
                style: const TextStyle(
                    fontFamily: 'Roboto-Bold',
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /*  Company Info  */
            Row(
              children: [
                widget.job.profile == null ||
                        widget.job.profile == "" ||
                        widget.job.profile == "no_profile"
                    ? const IconImage(iconImagePath: "assets/default.png")
                    : IconImage(
                        fromNetwork: true,
                        iconImagePath:
                            "$API_BASE_URL/uploads/${widget.job.profile!}"),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.job.company,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'Poppins-SemiBold'),
                    ),
                    CText(text: "Corpoartion"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /*  Job Applicants and Time Posted  */
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Posted: ${timeago.format(widget.job.posted)}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          color: Colors.grey),
                    )),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  " ${widget.job.applicants.toString()} Applicants",
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 10),
              child: Text(
                "Required Skills For This Job",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins-SemiBold',
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Divider(),
            widget.job.qualifications.isNotEmpty
                ? Wrap(
                    spacing: 4,
                    runSpacing: 0,
                    children: List.generate(
                        widget.job.qualifications.length,
                        (index) => Chip(
                              backgroundColor: Colors.grey[200],
                              shadowColor: Colors.red,
                              surfaceTintColor: Colors.grey[200],
                              label: Text(widget.job.qualifications[index]),
                            )))
                : const Padding(
                    padding: const EdgeInsets.only(left: 8, top: 20),
                    child: Text(""),
                  ),
            const SizedBox(
              height: 8,
            ),
            Divider(),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 10),
                  child: Text(
                    "Job Description",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Poppins-SemiBold',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.job.descripton,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Regular',
                        height: 1.5,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(top: 8, bottom: 12),
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: colors['primary'],
                    border: Border.all(color: Colors.transparent)),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: colors['primary'],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return showConfirmation(
                              context,
                              "Do You Want To Apply This Job, Job Offers Depends On The Company, confirm to apply this one",
                              "Confirmation", onConfirm: () {
                            LocalStorageSharedPref()
                                .getLocalData()
                                .then((value) {
                              var provider = Provider.of<JobProvider>(context,
                                  listen: false);

                              provider
                                  .hasData(value!['user_id'], widget.job.id)
                                  .whenComplete(() {
                                if (provider.isValidData) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (_) => showInfo(context,
                                          "Your've Already Applied This Job."));
                                  return;
                                }

                                var requestData = Request(
                                    applicantId: value['user_id'],
                                    jobId: widget.job.id,
                                    requestDate: DateTime.now().toString());
                                provider
                                    .applyJobsData(requestData)
                                    .whenComplete(() {
                                  if (provider.hasError) {
                                    Navigator.pop(context);
                                    EasyLoading.showError(provider.error);
                                  } else {
                                    Navigator.pop(context);

                                    EasyLoading.showSuccess(provider.response)
                                        .whenComplete(() {
                                      provider.getAllJobs().whenComplete(
                                          () => Navigator.pop(context));
                                    });
                                  }
                                });
                              });
                            });
                          });
                        });
                  },
                  child: Text(
                    applyJobTxt,
                    style: TextStyle(
                        fontSize: 18,
                        color:
                            Colors.white), // You might want to add a text color
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
