import 'package:flutter/cupertino.dart';

import '../modals/jobs/job_modal.dart';
import '../views/components/job_card.dart';

/// This mixin only builds the list of jobs
mixin BuildListViewJobCard{
  ListView buildJobListView(BuildContext context,List<Job> jobs) {
    return ListView.builder(
        itemCount: jobs.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (_, index) {
          return JobCard(job: jobs[index]);
        });
  }
}
