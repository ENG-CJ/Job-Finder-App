// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/consts/confirmationDialog.dart';
import 'package:job_finder/consts/floatToast.dart';
import 'package:job_finder/modals/jobs/job_table.dart';
import 'package:job_finder/modals/jobs/requestJobs.dart';
import 'package:job_finder/modals/users/user.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';
import 'package:job_finder/services/local/local_storage.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_text.dart';
import 'package:job_finder/util/profile.dart';
import 'package:job_finder/util/text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RecievedJobRequests extends StatefulWidget {
  const RecievedJobRequests({super.key});

  @override
  State<RecievedJobRequests> createState() => _RecievedJobRequestsState();
}

class _RecievedJobRequestsState extends State<RecievedJobRequests> {
  JobRequests? requests;
  User? user;
  JobTable? jobs;
  int? jobOwner;

  @override
  void initState() {
    super.initState();
    LocalStorageSharedPref().getLocalData().then((value) {
      if (value == null) {
        Navigator.pop(context);
      } else {
        var jobProvider = Provider.of<JobProvider>(context, listen: false);
        jobProvider.jobRequest(value["user_id"]);
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
                                    icon: FaIcon(FontAwesomeIcons.filter)),
                                const SizedBox(
                                  width: 10,
                                ),
                                CText(
                                  text: "Job Requets List",
                                  decorations: TextDecorations(
                                      fontSize: 17, family: "Poppins Medium"),
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => AddJob()));
                                },
                                icon: FaIcon(FontAwesomeIcons.plus)),
                          ],
                        ),
                      ),
                      _buildJobListView(context),
                    ],
                  ),
      ),
    ));
  }
}

Widget _buildJobListView(BuildContext context) {
  var provider = Provider.of<JobProvider>(context);
  return ListView.builder(
    itemCount: provider.requestedJobs.length,
    shrinkWrap: true,
    itemBuilder: (_, index) {
      var job = provider.requestedJobs[index];
      var requestedDate = DateTime.parse(job.reqDate);
      int reqId = job.reqId;
      return Padding(
        padding: const EdgeInsets.only(top: 19, left: 7, right: 7, bottom: 5),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(19),
              width: double.maxFinite,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0xFFd6d5e5).withOpacity(1),
                  offset: Offset(-1, 6),
                  blurRadius: 26,
                  spreadRadius: -4,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      job.profilePic == "null" || job.profilePic == "no_profile"
                          ? const ProfileImage(
                              imagePath: "assets/default.png",
                              asBackgroundImage: true,
                            )
                          : ProfileImage(
                              imagePath:
                                  "$API_BASE_URL/uploads/${job.profilePic}",
                              fromNetwork: true,
                              asBackgroundImage: true,
                            ),
                      const SizedBox(
                        width: 16,
                      ),
                      CText(
                        text: job.userName,
                        decorations: TextDecorations(
                            fontSize: 16, family: "Poppins SemiBold"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "The Applicant",
                            style: TextStyle(
                                fontSize: 15, fontFamily: "Poppins Light")),
                        WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                            text: job.userName,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins Light",
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid)),
                        WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                            text: "Requested",
                            style: TextStyle(
                                fontSize: 15, fontFamily: "Poppins Light")),
                        WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                            text: job.jobTitle,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins Light",
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid)),
                        WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                            text: "On",
                            style: TextStyle(
                                fontSize: 15, fontFamily: "Poppins Light")),
                        WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                            text:
                                DateFormat("yyyy/MM/dd").format(requestedDate),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins Light",
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid)),
                      ])),
                  // CText(
                  //     decorations: TextDecorations(
                  //         fontSize: 15, family: "Poppins Light"),
                  //     text: "The Applicant ${job.userName} Requested ${job.jobTitle} On ${  DateFormat("yyyy/MM/dd").format(requestedDate)}"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CButton(
                          width: 100,
                          onClicked: () {
                            String status = "Declined";
                            provider.isLoading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: colors['primary'] as Color, size: 80)
                                : provider.hasError
                                    ? const Text("There is an error")
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConfirmationDialog(
                                              title: "Confirm",
                                              alertContent:
                                                  "You Want to Decline the Incoming clicked request",
                                              callBackFunction: () {
                                                provider
                                                    .updateStatus(reqId, status)
                                                    .whenComplete(() {
                                                  // const CustomSnackBar(
                                                  //   toastMessage:
                                                  //   "Successfully Rejected a new job requets",
                                                  //   type: "Failure",
                                                  // ).showCustomSnackbar(context);

                                                  LocalStorageSharedPref()
                                                      .getLocalData()
                                                      .then((value) {
                                                    if (value == null) {
                                                      Navigator.pop(context);
                                                    } else {
                                                      provider.jobRequest(
                                                          value["user_id"]);
                                                    }
                                                  });
                                                });
                                              });
                                        });
                          },
                          backgroundColor:
                              colors['error-color']!.withOpacity(0.8) as Color,
                          widget: const Center(
                            child: IconText(
                              textColor: Colors.white,
                              icon: FontAwesomeIcons.ban,
                              iconLabel: "Decline",
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      CButton(
                          width: 100,
                          onClicked: () async {
                            String status = "Accepted";
                            provider.isLoading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: colors['primary'] as Color, size: 80)
                                : provider.hasError
                                    ? const Text("There is an error")
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConfirmationDialog(
                                              title: "Confirm",
                                              alertContent:
                                                  "You Want to Accept the Incoming clicked request",
                                              callBackFunction: () {
                                                provider
                                                    .updateStatus(reqId, status)
                                                    .whenComplete(() {
                                                  LocalStorageSharedPref()
                                                      .getLocalData()
                                                      .then((value) {
                                                    if (value == null) {
                                                      Navigator.pop(context);
                                                    } else {
                                                      provider.jobRequest(
                                                          value["user_id"]);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  content:
                                                                      CText(
                                                        text:
                                                            "You Accepted ${job.userName} His/Her Request",
                                                      )));
                                                    }
                                                  });
                                                });
                                              });
                                        });
                          },
                          backgroundColor:
                              colors['primary']!.withOpacity(0.5) as Color,
                          widget: const Center(
                            child: IconText(
                              icon: FontAwesomeIcons.check,
                              iconLabel: "Accept",
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                top: 10,
                right: 20,
                child: job.status == "Accepted"
                    ? Tooltip(
                        message: "Accepted Request",
                        child: Icon(
                          Icons.check,
                          color: colors["primary"],
                        ),
                      )
                    : Tooltip(
                        message: "Rejected Or Pending Request",
                        child: Icon(
                          FontAwesomeIcons.xmark,
                          color: colors["error-color"],
                        ),
                      ))
          ],
        ),
      );
    },
  );
}
