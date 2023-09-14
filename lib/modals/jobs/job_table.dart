class JobTable {
  String jobTitle, jobType, deadLine;

  List<String>? qualifications;
  String? jobDescription, id, qualifyAsList, updated;
  int? jobOwner;
  String active;
  int numberOfApplicants;
  String? category;
  String posted;

  JobTable({
    required this.jobTitle,
    required this.jobType,
    required this.deadLine,
    required this.posted,
    this.qualifications,
    this.category,
    this.id,
    this.updated,
    this.jobDescription = '',
    this.jobOwner,
    this.qualifyAsList = '',
    this.active = 'true',
    this.numberOfApplicants = 0,
  });

  factory JobTable.fromJson(Map<String, dynamic> json) {
    return JobTable(
        id: json['id'],
        jobTitle: json['jobTitle'],
        jobType: json['jobType'],
        deadLine: json['deadLine'].toString(),
        qualifications: _getQualifications(json['qualifications']),
        numberOfApplicants: json['applicants'],
        active: json['active'],
        jobOwner: json['owner'],
        jobDescription: json['descripton'],
        updated: json['updated'],
        posted: json['posted']);
  }

  static List<String> _getQualifications(String data) {
    var listData = <String>[];
    if (data != "" || data.isNotEmpty) {
      listData = data.split(",");
      return listData;
    }

    return listData;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "jobTitle": jobTitle,
      "category": category,
      "jobType": jobType,
      "jobDescription": jobDescription,
      "deadLine": deadLine,
      "applicants": numberOfApplicants,
      "active": active,
      "owner": jobOwner,
      "qualifications": qualifications,
      "qualifyAsList": qualifyAsList,
      "posted": posted
    };
  }
}
