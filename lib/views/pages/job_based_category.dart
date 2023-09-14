import 'package:flutter/material.dart';
import 'package:job_finder/mixins/no_data_found_error.dart';
import 'package:job_finder/modals/jobs/job_modal_latest.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/job_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../consts/colors.dart';

class JobBasedCategory extends StatefulWidget {
  final String category;
  const JobBasedCategory({super.key, required this.category});

  @override
  State<JobBasedCategory> createState() => _JobBasedCategoryState();
}

class _JobBasedCategoryState extends State<JobBasedCategory>
    with NoDataErrorMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<JobProvider>(builder: (_, data, child) {
        return data.isLoading
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: colors['primary'] as Color, size: 70))
            : data.hasError
                ? noDataError(context, "Reload", "Error Occured While Fetching",
                    data.error, (context, result) {})
                : _buildWidgetView(context, data.jobsBasedOnCategory);
      })),
    );
  }

  Widget _buildWidgetView(
      BuildContext context, List<JobOnUserScreen> jobsBasedOnCategory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 10),
            Text(
              widget.category,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: CText(text: "View All Jobs Related ${widget.category}"),
        ),
        SizedBox(height: 20),
        ListView.builder(
            shrinkWrap: true,
            itemCount: jobsBasedOnCategory.length,
            itemBuilder: (context, index) {
              var job = jobsBasedOnCategory[index];
              return JobCard(job: job);
            })
      ],
    );
  }
}
