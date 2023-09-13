import 'package:flutter/material.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import '../../../consts/colors.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({
    super.key,
    required this.jobTitle,
    required this.jobType,
    required this.jobDate,
    required this.qualification,
    required this.jobDescription,
    this.comLogo,
  });

  final String jobTitle;
  final String jobType;
  final String jobDate;
  final List<String>? qualification;
  final String? jobDescription;
  final String? comLogo;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: mediaQuery.height * 0.98,
              margin: const EdgeInsets.only(top: 35, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.logo_dev_outlined,
                    size: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: CText(
                        text: jobType,
                        decorations: TextDecorations(
                          fontSize: 16,
                          color: colors['primary']!.withOpacity(0.7),
                        ),
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: CText(
                      text: jobTitle,
                      decorations: TextDecorations(
                        fontSize: 24,
                        family: 'Poppins-Bodl',
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: CText(
                      text: 'Deadline: $jobDate',
                      decorations: TextDecorations(
                          fontSize: 16,
                          family: 'Poppins-loght',
                          weight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  qualification != null && qualification!.isNotEmpty
                      ? Wrap(
                          spacing: 4,
                          runSpacing: 0,
                          children: List.generate(
                              qualification!.length,
                              (index) => Chip(
                                    backgroundColor: Colors.grey[200],
                                    shadowColor: Colors.red,
                                    surfaceTintColor: Colors.grey[200],
                                    label: Text(qualification![index]),
                                  )))
                      : const Padding(
                          padding: const EdgeInsets.only(left: 8, top: 20),
                          child: Text(""),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: CText(
                      text: 'About the Role',
                      decorations: TextDecorations(
                        fontSize: 18,
                        family: 'Roboto-Bold',
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7, right: 12),
                    child: Container(
                        // height: mediaQuery.height * 0.5,
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          jobDescription!,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto-Light',
                              fontWeight: FontWeight.normal),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
