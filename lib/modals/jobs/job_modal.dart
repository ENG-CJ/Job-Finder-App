class Job {
  String jobTitle, corporation, companyLogoPath, jobDescription,timePosted;
  int numberOfApplicants;
  int? jobSalary;
  String? about,jobLevel,jobLocation;
  List<String>? softSkills;

  Job({
    required this.jobTitle,
    required this.corporation,
    required this.companyLogoPath,
    required this.jobDescription,
    required this.numberOfApplicants,
    required this.timePosted,
    this.jobSalary,
    this.about,
    this.jobLevel,
    this.jobLocation,
    this.softSkills
  });
}
