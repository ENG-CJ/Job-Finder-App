import 'dart:io';

class User {
  String username, email, password;
  int mobile;
  String regionOrCity;
  String type;
  String verified;
  String? description, address;
  int? id;
  String? imagePath;
  File? imageFile;


  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.regionOrCity,
      required this.mobile,
      this.imageFile,
      this.imagePath,
      this.address,
      this.description,
      this.id,
      this.verified = 'false',
      this.type = 'User',
   
      });

  

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      imagePath: jsonData['profile_pic'],
      id: jsonData['id'] ?? "",
      username: jsonData['username'],
      email: jsonData['email'],
      password: jsonData['password'],
      regionOrCity: jsonData['country'],
      mobile: jsonData['mobile'],
      address: jsonData['address'],
      description: jsonData['description'],
      type: jsonData['type'],
      verified: jsonData['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "mobile": mobile,
      "country": regionOrCity,
      "type": type,
      "oldImage": imagePath,
      "verified": verified,
      "description": description,
      "address": address
    };
  }
}
