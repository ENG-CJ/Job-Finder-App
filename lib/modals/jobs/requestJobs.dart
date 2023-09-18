import 'package:job_finder/modals/jobs/job_modal.dart';

class JobRequests{
  String status,jobTitle,userName,profilePic,jobId,reqDate;
  int reqId,appId;

  

  JobRequests({
    required this.reqId,
    required this.appId,
   required this.jobId,
   required this.reqDate,
   required this.status,
   required this.jobTitle,
   required this.userName,
   required this.profilePic,
});

 factory JobRequests.fromJson(Map<String, dynamic> json){
  return JobRequests(
    reqId: json['req_id'],
    appId: json['applicant_id'],
    jobId: json['job_id'],
    reqDate: json['request_date'],
    status: json['status'],
    jobTitle: json['jobTitle'],
    userName: json['username'],
    profilePic: json['profile_pic']
  );
 }

}