class Request {
  int? reqId;
  int applicantId;
  String jobId;
  String requestDate;
  String? status;
  String? jobTitle;
  String? username;
  String? profilePic;
  String? requestedTime;

  Request({
    required this.applicantId,
    required this.jobId,
    required this.requestDate,
    this.reqId,
    this.status,
    this.jobTitle,
    this.username,
    this.profilePic,
    this.requestedTime,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        reqId: json["req_id"],
        applicantId: json["applicant_id"],
        jobId: json["job_id"],
        requestDate: (json["request_date"]),
        status: json["status"],
        jobTitle: json["jobTitle"],
        username: json["username"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "applicant_id": applicantId,
        "job_id": jobId,
        "date": requestDate,
      };
}
