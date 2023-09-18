import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/modals/jobs/job_table.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';
import 'package:job_finder/services/local/local_storage.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/custom_text_field.dart';
import 'package:job_finder/util/dropdown_menu.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../consts/colors.dart';
import '../../../mixins/messages.dart';
import '../../../providers/users/user_provider.dart';
import '../../../util/helpers/text_helper.dart';
import '../../../util/text.dart';

class AddJob extends StatefulWidget {
  const AddJob({super.key});

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> with Messages {
  final jobtitle = TextEditingController();
  final dateTextField = TextEditingController(
      text: DateFormat("yyyy/MM/dd").format(DateTime.now()));
  final qualify = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();

  String? value;
  int? id;

  var initialDateValue = DateTime.now();

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

  void _saveData() async {
    var provider = Provider.of<JobProvider>(context, listen: false);
    var job = JobTable(
        posted: DateTime.now().toString(),
        jobTitle: jobtitle.text,
        jobType: value ?? "FullTime",
        deadLine: dateTextField.text,
        jobDescription: description.text,
        qualifyAsList: qualify.text,
        jobOwner: id);
    await provider.saveJobData(job);
  }

  @override
  void initState() {
    super.initState();
    LocalStorageSharedPref().getLocalData().then((value) {
      if (value != null) {
        var provider = Provider.of<UserProvider>(context, listen: false);
        provider.fetchUser(value['user_id']).whenComplete(() {
          if (provider.user != null) {
            setState(() {
              id = provider.user!.id;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        blur: 1,
        color: Colors.white,
        progressIndicator: LoadingAnimationWidget.fourRotatingDots(
            color: colors['primary'] as Color, size: 80),
        inAsyncCall: Provider.of<JobProvider>(context).isSaving,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 6, right: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: FaIcon(FontAwesomeIcons.angleLeft)),
                    SizedBox(
                      width: 10,
                    ),
                    CText(
                      text: "Create New Job And Auto Publish",
                      decorations: TextDecorations(
                          fontSize: 17, family: "Poppins Medium"),
                    ),
                  ],
                ),
                CustomTextField(
                    txtInputType: TextInputType.text,
                    hintText: "Job Title",
                    prefixIcon: Icon(FontAwesomeIcons.suitcase),
                    controller: jobtitle),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    txtInputType: TextInputType.text,
                    hintText: "Category",
                    prefixIcon: Icon(FontAwesomeIcons.suitcase),
                    controller: category),
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
                      onClicked: () async {
                        var provider =
                            Provider.of<JobProvider>(context, listen: false);
                        var job = JobTable(
                            posted: DateTime.now().toString(),
                            category: category.text,
                            jobTitle: jobtitle.text,
                            jobType: value ?? "FullTime",
                            deadLine: dateTextField.text,
                            jobDescription: description.text,
                            qualifyAsList: qualify.text,
                            jobOwner: id);

                        provider.saveJobData(job).whenComplete(() {
                          if (provider.hasError) {
                            EasyLoading.showError(provider.error);
                          } else {
                            EasyLoading.showSuccess(provider.response);
                            provider.fetchJobs(id!);
                          }
                        });
                      },
                      backgroundColor: colors['primary'] as Color,
                      padding: 20,
                      width: double.maxFinite,
                      widget: Center(
                        child: CText(
                          text: "Save Data",
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
        )),
      ),
    );
  }
}
