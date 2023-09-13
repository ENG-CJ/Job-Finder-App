class JobOnUserScreen {
  String id;
  String jobTitle;
  String jobType;
  String descripton;
  String qualifications;
  int applicants;
  DateTime deadLine;
  DateTime updated;
  int owner;
  String company;
  String? profile;

  JobOnUserScreen({
    required this.id,
    required this.jobTitle,
    required this.jobType,
    required this.descripton,
    required this.qualifications,
    required this.applicants,
    required this.deadLine,
    required this.updated,
    required this.owner,
    required this.company,
    required this.profile,
  });

  factory JobOnUserScreen.fromJson(Map<String, dynamic> json) =>
      JobOnUserScreen(
        id: json["id"],
        jobTitle: json["jobTitle"],
        jobType: json["jobType"],
        descripton: json["descripton"],
        qualifications: json["qualifications"],
        applicants: json["applicants"],
        deadLine: DateTime.parse(json["deadLine"]),
        updated: DateTime.parse(json["updated"]),
        owner: json["owner"],
        company: json["company"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobTitle": jobTitle,
        "jobType": jobType,
        "descripton": descripton,
        "qualifications": qualifications,
        "applicants": applicants,
        "deadLine": deadLine.toIso8601String(),
        "updated": updated.toIso8601String(),
        "owner": owner,
        "company": company,
        "profile": profile,
      };
}
