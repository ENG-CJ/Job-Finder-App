class User {
  String username, email, password;
  int mobile;
  String regionOrCity;
  String type;
  String verified;
  String? description, address;
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
      this.type = 'User'});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData['id'] ?? "",
        username: jsonData['username'],
        email: jsonData['email'],
        password: jsonData['password'],
        regionOrCity: jsonData['country'],
        mobile: int.parse(jsonData['mobile']),
        address: jsonData['address'],
        description: jsonData['description'],
        type: jsonData['type'],
        verified: jsonData['verified']);
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
