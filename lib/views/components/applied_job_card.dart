import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:job_finder/services/local/local_storage.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/text.dart';
import 'package:provider/provider.dart';

import '../../consts/colors.dart';
import '../../mixins/messages.dart';
import '../../modals/jobs/applied_jobs.dart';
import '../../modals/jobs/requests.dart';
import '../../providers/jobs/job_provider.dart';
import '../../util/icon_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'job_header.dart';

class AppliedJobCard extends StatefulWidget {
  final Request request;
  const AppliedJobCard({super.key, required this.request});

  @override
  State<AppliedJobCard> createState() => _AppliedJobCardState();
}

class _AppliedJobCardState extends State<AppliedJobCard> with Messages {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onClickIcon: () async {
              await showDialog(
                  context: context,
                  builder: (_) {
                    return showConfirmation(
                        context,
                        "Do You Want to Remove This Request?",
                        "Are You Sure", onConfirm: () {
                      Navigator.of(context).pop();
                      var provider =
                          Provider.of<JobProvider>(context, listen: false);
                      provider
                          .deleteRequest(
                              widget.request.reqId!, widget.request.jobId!)
                          .whenComplete(() {
                        if (provider.hasError) {
                          EasyLoading.showError(provider.error);
                        } else {
                          EasyLoading.showSuccess(
                              "Request Removed Successfully");
                          LocalStorageSharedPref().getLocalData().then((value) {
                            provider.fetchRequests(value!['user_id']);
                          });
                        }
                      });
                    });
                  });
            },
            icon: FontAwesomeIcons.minus,
            company: widget.request.username!,
            jobTitle: widget.request.jobTitle!,
            logo: widget.request.profilePic!,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconText(
                  icon: FontAwesomeIcons.clock,
                  iconLabel: timeago
                      .format(DateTime.parse(widget.request.requestDate)),
                ),
                SizedBox(
                  width: 25,
                ),
                _buildStatusButton(context, widget.request.status!)
              ],
            ),
          ),
          // SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget _buildStatusButton(BuildContext context, String status) {
    switch (status) {
      case "Pending":
        return CButton(
            backgroundColor: colors['orange-color']!.withOpacity(0.3),
            widget: Center(child: CText(text: widget.request.status!)));
      case "Declined":
        return CButton(
            backgroundColor: colors['error-color']!.withOpacity(0.7),
            widget: Center(child: CText(text: widget.request.status!)));
      default:
        return CButton(
            backgroundColor: colors['success-color']!.withOpacity(0.6),
            widget: Center(child: CText(text: widget.request.status!)));
    }
  }
}
