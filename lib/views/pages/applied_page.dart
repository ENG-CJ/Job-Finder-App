import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/mixins/bottom_navigation_mixin.dart';
import 'package:job_finder/mixins/no_data_found_error.dart';
import 'package:job_finder/modals/jobs/applied_jobs.dart';
import 'package:job_finder/modals/jobs/job_modal.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/filter_dailog.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_image.dart';
import 'package:job_finder/util/icon_text.dart';
import 'package:job_finder/util/profile.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/applied_job_card.dart';
import 'package:job_finder/views/components/job_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../consts/colors.dart';
import '../../modals/jobs/requests.dart';
import '../../providers/jobs/job_provider.dart';
import '../../services/local/local_storage.dart';

class AppliedPage extends StatefulWidget {
  const AppliedPage({super.key});

  @override
  State<AppliedPage> createState() => _AppliedPageState();
}

class _AppliedPageState extends State<AppliedPage>
    with BottomNavigationBarMixin, NoDataErrorMixin {
  List<Request>? requests;

  @override
  void initState() {
    super.initState();
    LocalStorageSharedPref().getLocalData().then((value) {
      if (value != null) {
        Provider.of<JobProvider>(context, listen: false)
            .fetchRequests(value['user_id']);
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
        inAsyncCall: Provider.of<JobProvider>(context).isDeleting,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileImage(
                          radius: 30,
                          asBackgroundImage: true,
                          imagePath: "assets/me.jpeg"),
                      CText(
                        text: "Applied Jobs",
                        decorations: TextDecorations(
                            color: colors['secondary'] as Color,
                            fontSize: 20,
                            family: "Poppins SemiBold"),
                      ),
                      CButton(
                          onClicked: () async {
                            var data = await showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: IconText(
                                      icon: FontAwesomeIcons.filter,
                                      iconLabel: "Choose Filter",
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor:
                                        colors['white-color'] as Color,
                                    content: FilterDialog(),
                                    scrollable: true,
                                  );
                                });

                            print(data);
                          },
                          width: 45,
                          radius: 50,
                          backgroundColor: colors['primary']!.withOpacity(0.2),
                          widget:
                              Center(child: FaIcon(FontAwesomeIcons.filter)))
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Consumer<JobProvider>(builder: (_, data, child) {
                  return data.isLoading
                      ? Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                              color: colors['primary'] as Color, size: 70))
                      : data.hasError
                          ? noDataError(
                              context,
                              "Retry",
                              "Something Went Wrong",
                              data.error, (context, result) {
                              Provider.of<JobProvider>(context, listen: false)
                                  .getAllJobs();
                            })
                          : _buildRequestsListView(context, data.requests);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildRequestsListView(BuildContext context, List<Request> requests) {
    return ListView.separated(
        separatorBuilder: (_, i) => SizedBox(
              height: 20,
            ),
        itemCount: requests.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (_, index) => AppliedJobCard(request: requests[index]));
  }
}
