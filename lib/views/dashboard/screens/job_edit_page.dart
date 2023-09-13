import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/modals/jobs/job_table.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/services/local/local_storage.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/custom_text_field.dart';
import 'package:job_finder/util/dropdown_menu.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:provider/provider.dart';

class JobEditPage extends StatefulWidget {
  final JobTable? job;
  const JobEditPage({
    super.key,
   
    this.job,
 
  });

  @override
  State<JobEditPage> createState() => _JobEditPageState();
}

class _JobEditPageState extends State<JobEditPage> {
  final jobtitle = TextEditingController();
  final dateTextField = TextEditingController(
      text: DateFormat("yyyy/MM/dd").format(DateTime.now()));
  final qualify = TextEditingController();
  final description = TextEditingController();

  String? value;
  String? jobId;
  int? owner;
  late String qualificationConcat;

  void _showDatePicker(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2040));

    if (date != null) {
      setState(() {
        dateTextField.text = DateFormat("yyyy/MM/dd").format(date);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    jobId = widget.job?.id;
    owner = widget.job?.jobOwner;
    value = widget.job?.jobType;
    jobtitle.text = widget.job!.jobTitle; 
    
    String iso8601DateString  = widget.job!.deadLine;
    DateTime dealine = DateTime.parse(iso8601DateString);
    dateTextField.text = DateFormat("yyyy/MM/dd").format(dealine);
    print(dateTextField.text);
    String qualifyText = widget.job?.qualifications?.toString() ?? '';
    description.text = widget.job?.jobDescription ?? 'It is Null';
    if (qualifyText.startsWith('[') && qualifyText.endsWith(']')) {
      qualify.text = qualifyText.substring(1, qualifyText.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<JobProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.grey,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                txtInputType: TextInputType.text,
                hintText: "Job Title",
                prefixIcon: Icon(FontAwesomeIcons.suitcase),
                controller: jobtitle),
            SizedBox(
              height: 10,
            ),
            CustomDropdownMenu(
                value: value,
                onChange: (newValue) {
                  setState(() {
                    value = newValue;
                  });
                }),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                suffixIconFunction: () => _showDatePicker(context),
                suffixIcon: Icon(FontAwesomeIcons.calendar),
                txtInputType: TextInputType.text,
                hintText: "Deadline",
                controller: dateTextField),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                minLines: 1,
                maxLines: 5,
                txtInputType: TextInputType.text,
                hintText: "Qualifications",
                prefixIcon: Icon(FontAwesomeIcons.layerGroup),
                controller: qualify),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CText(
                text: "Use Comma to enter multiple qualifications",
                decorations: TextDecorations(color: Colors.grey.shade500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                minLines: 1,
                maxLines: 100,
                txtInputType: TextInputType.text,
                hintText: "Job Description",
                prefixIcon: Icon(FontAwesomeIcons.hashtag),
                controller: description),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CButton(
                  onClicked: () {
                    JobTable updateJob = JobTable(
                        id: jobId,
                        jobTitle: jobtitle.text,
                        jobType: value ?? '',
                        deadLine: dateTextField.text,
                        jobDescription: description.text,
                        qualifyAsList: qualify.text,
                        );
                        print("Job Date is  : ${dateTextField.text}");
                    provider.updateJob(updateJob).whenComplete(() {
                      provider.fetchJobs(owner!);
                      print("Done");
                    });
                  },
                  backgroundColor: colors['primary'] as Color,
                  padding: 20,
                  width: double.maxFinite,
                  widget: Center(
                    child: CText(
                      text: "Update Data",
                      decorations: TextDecorations(
                          color: Colors.white,
                          fontSize: 17,
                          family: "Poppins Medium"),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
