import 'package:dio/dio.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/modals/users/user.dart';

class UserAPIServices {
  final _dio = Dio();

  Future<dynamic> registerUser(User user) async {
    dynamic response;
    try {
      print(user.imageFile ?? "no data");
      if (user.imageFile != null) {
        var formData = FormData.fromMap({
          "username": user.username,
          "email": user.email,
          "password": user.password,
          "mobile": user.mobile,
          "country": user.regionOrCity,
          "type": user.type,
          "verified": user.verified,
          "description": user.description,
          "address": user.address,
          "profile_pic": await MultipartFile.fromFile(user.imageFile!.path)
        });
        response =
            await _dio.post('$API_BASE_URL/users/register', data: formData);
      } else {
        response = await _dio.post('$API_BASE_URL/users/register',
            data: user.toJson());
      }
    } on DioException catch (e) {
      print(e.response!.data);
      return Future.error(
          {"error": e.message, "description": e.response!.data['description']});
    }

    return response.data;
  }

  Future<User?> getUserWithCredentials(Map<String, dynamic> data) async {
    User? user;
    try {
      var response = await _dio.post("$API_BASE_URL/users/login", data: data);
      if (response.data['userData'].length > 0) {
        user = User.fromJson((response.data['userData'] as List).first);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print("error $e");
    }

    return user;
  }

  Future<User?> fetchUserDetails(int id) async {
    User? user;
    try {
      var response =
          await _dio.post("$API_BASE_URL/users/fetch", data: {"id": id});
      if (response.data['userData'].length > 0) {
        user = User.fromJson((response.data['userData'] as List).first);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print("error $e");
    }

    return user;
  }

  Future<dynamic> updateUser(User user) async {
    dynamic response;
    try {
      if (user.imageFile != null) {
        print("api part image path is ${user.imagePath}");
        var formData = FormData.fromMap({
          "id": user.id,
          "username": user.username,
          "email": user.email,
          "oldImage": user.imagePath,
          "password": user.password,
          "mobile": user.mobile,
          "country": user.regionOrCity,
          "type": user.type,
          "verified": user.verified,
          "description": user.description,
          "address": user.address,
          "profile_pic": await MultipartFile.fromFile(user.imageFile!.path)
        });

        response =
            await _dio.post("$API_BASE_URL/users/update", data: formData);
        print("with file compoleted");
      } else {
        response =
            await _dio.post("$API_BASE_URL/users/update", data: user.toJson());
        print("no file completed ");
      }
    } on DioException catch (err) {
      return Future.error({
        "error": err.response!.data['message'],
        "description": err.response!.data['description']
      });
    }
    return response.data;
  }
}
