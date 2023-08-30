import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import '../../consts/texts.dart';
import '../../modals/jobs/job_modal.dart';

class JobDetails extends StatelessWidget {
  final Job job;

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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(job.companyLogoPath),
                      height: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  job.corporation,
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
                      job.timePosted,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          color: Colors.grey),
                    )),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  " ${job.numberOfApplicants.toString()} Applicants",
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
            /*  Salary, Job Type, Job Level  */
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(Icons.work),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 12, top: 10),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: job.jobSalary == null
                                    ? "Salary is not specified yet!"
                                    : job.jobSalary.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Light',
                                    color: Colors.black)),
                            const WidgetSpan(
                              child: SizedBox(
                                  width: 10), // Adjust the width as needed
                            ),
                            const TextSpan(
                                text: ": ${fullTime}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins-Light',
                                    color: Colors.black)),
                            const WidgetSpan(
                              child: SizedBox(
                                  width: 10), // Adjust the width as needed
                            ),
                            TextSpan(
                                text: job.jobLevel == null
                                    ? ": $jobLevel"
                                    : job.jobLevel!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins-Light',
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            /*  Location  */
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Icon(Icons.map)),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(job.jobLocation != null
                      ? job.jobLocation!
                      : "Unspecified Location"),
                )
              ],
            ),
             SizedBox(
              height: 10,
            ),
            /*  Soft Skills  */
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.skateboarding_outlined),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${softSkillsTxt} :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-SemiBold',
                  ),
                )
              ],
            ),
            job.softSkills != null && job.softSkills!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 12, right: 5),
                    child: Wrap(
                        spacing: 4,
                        runSpacing: 0,
                        children: List.generate(
                            job.softSkills!.length,
                            (index) => Chip(
                                  backgroundColor: Colors.grey[200],
                                  shadowColor: Colors.red,
                                  surfaceTintColor: Colors.grey[200],
                                  label: Text(job.softSkills![index]),
                                ))),
                  )
                : const Padding(
                    padding: const EdgeInsets.only(left: 8, top: 20),
                    child: Text(""),
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
                    job.about != null && job.about!.isNotEmpty
                        ? job.about!
                        : "",
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Regular',
                        height: 1.5,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
                margin: EdgeInsets.only(top: 8,bottom: 12),
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: colors['primary'],
                    border: Border.all(color: Colors.transparent)),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: colors['primary'],
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
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
