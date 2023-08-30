import 'package:job_finder/modals/jobs/job_modal.dart';

class AppliedJobs{
  String companyLogo,jobTitle,company,timePosted;
  String status;

  AppliedJobs({
    required this.companyLogo,
    required this.company,
    required this.jobTitle,
    required this.timePosted,
    this.status="Pending"
});


}