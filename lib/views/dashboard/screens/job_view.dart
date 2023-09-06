import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/mixins/no_data_found_error.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_text.dart';
import 'package:job_finder/util/text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../consts/colors.dart';
import '../../../mixins/messages.dart';
import '../../../modals/jobs/job_table.dart';
import '../../../providers/jobs/job_provider.dart';
import '../../../providers/users/user_provider.dart';
import '../../../services/local/local_storage.dart';
import '../../../util/buton.dart';
import 'add_job.dart';

class JobView extends StatefulWidget {
  const JobView({super.key});

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> with NoDataErrorMixin, Messages {
  int? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadJobs();
  }

  void loadJobs() {
    LocalStorageSharedPref().getLocalData().then((value) {
      if (value != null) {
        var provider = Provider.of<UserProvider>(context, listen: false);
        var jobProvider = Provider.of<JobProvider>(context, listen: false);
        provider.fetchUser(value['email']).whenComplete(() {
          if (provider.user != null) {
            jobProvider.fetchJobs(provider.user!.id!);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<JobProvider>(context);
    return Scaffold(
      body: ModalProgressHUD(
        blur: 1,
        color: Colors.white,
        progressIndicator: LoadingAnimationWidget.fourRotatingDots(
            color: colors['primary'] as Color, size: 80),
        inAsyncCall: provider.isDeleting,
        child: SafeArea(
          child: provider.isLoading
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: colors['primary'] as Color, size: 80),
                )
              : provider.hasError
                  ? Text(provider.error)
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: FaIcon(FontAwesomeIcons.angleLeft)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CText(
                                    text: "View And Manage Job List",
                                    decorations: TextDecorations(
                                        fontSize: 17, family: "Poppins Medium"),
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AddJob()));
                                  },
                                  icon: FaIcon(FontAwesomeIcons.plus)),
                            ],
                          ),
                        ),
                        _buildJobListView(context, provider.jobs),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildJobListView(BuildContext context, List<JobTable> jobs) {
    return ListView.builder(
        itemCount: jobs.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          var job = jobs[index];
          return Padding(
            padding:
                const EdgeInsets.only(top: 19, left: 7, right: 7, bottom: 5),
            child: Container(
                padding: EdgeInsets.all(19),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFd6d5e5).withOpacity(1),
                        offset: Offset(-1, 6),
                        blurRadius: 26,
                        spreadRadius: -4,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: job.jobTitle,
                      decorations: TextDecorations(
                          fontSize: 20, family: "Poppins SemiBold"),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    CText(
                        decorations: TextDecorations(
                            fontSize: 15, family: "Poppins Light"),
                        text: job.jobDescription == ""
                            ? "No Description Available for This Job"
                            : job.jobDescription ??
                                "No Description Available for This Job"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CButton(
                            width: 90,
                            onClicked: () => print("Hello"),
                            backgroundColor:
                                colors['primary']!.withOpacity(0.5) as Color,
                            widget: Center(
                              child: IconText(
                                icon: FontAwesomeIcons.pen,
                                iconLabel: "Edit",
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        CButton(
                            width: 90,
                            onClicked: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => showConfirmation(
                                          context,
                                          "Are you sure to delete this job?",
                                          "Confirm", onConfirm: () {
                                        Navigator.pop(context);
                                        var provider = Provider.of<JobProvider>(
                                            context,
                                            listen: false);
                                        provider
                                            .deleteJobData(job.id)
                                            .whenComplete(() {
                                          if (provider.hasError)
                                            EasyLoading.showError(
                                                provider.error);
                                          else {
                                            loadJobs();
                                          }
                                        });
                                      }));
                            },
                            backgroundColor: colors['error-color']!
                                .withOpacity(0.8) as Color,
                            widget: Center(
                              child: IconText(
                                textColor: Colors.white,
                                icon: FontAwesomeIcons.xmark,
                                iconLabel: "Delete",
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        CButton(
                            width: 90,
                            onClicked: () => print("Hello"),
                            backgroundColor:
                                colors['primary']!.withOpacity(0.5) as Color,
                            widget: Center(
                              child: IconText(
                                icon: FontAwesomeIcons.eye,
                                iconLabel: "View",
                              ),
                            )),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
