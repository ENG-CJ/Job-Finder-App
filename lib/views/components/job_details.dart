import 'package:flutter/material.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/modals/jobs/job_modal_latest.dart';
import '../../consts/api_url.dart';
import '../../consts/texts.dart';
import '../../util/icon_image.dart';

class JobDetails extends StatelessWidget {
  final JobOnUserScreen job;

  const JobDetails({super.key, required this.job});

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
                job.jobTitle,
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
                job.profile == null || job.profile == "" || job.profile == ""
                    ? const IconImage(iconImagePath: "assets/default.png")
                    : IconImage(
                        iconImagePath: "$API_BASE_URL/uploads/${job.profile!}"),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  job.company,
                  style:
                      TextStyle(fontSize: 16, fontFamily: 'Poppins-SemiBold'),
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
                      "1day ago",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          color: Colors.grey),
                    )),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  " ${job.applicants.toString()} Applicants",
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
                    job.descripton,
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
                  onPressed: () {},
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
