import 'dart:ui';

class User {
  String username, email, password;
  int mobile;
  String regionOrCity;
  String type;
  String verified;
  String? description, address, profile_pic_base64,profile_pic ;
  int? id;
  

  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.regionOrCity,
      required this.mobile,
      this.address,
      this.description,
      this.id,
      this.verified = 'false',
      this.type = 'User',
      this.profile_pic
      });

  

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
    id: jsonData['id'] ?? "",
    username: jsonData['username'],
    email: jsonData['email'],
    password: jsonData['password'],
    regionOrCity: jsonData['country'],
    mobile: (jsonData['mobile'] is int)
        ? jsonData['mobile'] 
        : int.parse(jsonData['mobile'].toString()), 
    address: jsonData['address'],
    description: jsonData['description'],
    type: jsonData['type'],
    verified: jsonData['verified'],
    profile_pic: jsonData['profile_pic'] is String 
      ? jsonData['profile_pic'] 
      : null,
  );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "phone": mobile,
      "country": regionOrCity,
      "type": type,
      "verified": verified,
      "description": description,
      "address": address
    };
  }
}
