
class Profile{
  String userName,userEmail,phone;
  String? bio,city,professional,sex,imageUrl;
  List<String>? otherSkills,languages;
  DateTime? DOB;
  // ui.Image? profileImage;

  Profile({
    required this.userName,
    required this.userEmail,
    required this.phone,
    this.city,
    this.professional,
    this.sex,
    this.bio,
    this.DOB,
    this.otherSkills,
    this.languages,
    this.imageUrl,
    // this.profileImage
});

}