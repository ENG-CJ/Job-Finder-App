import 'package:dio/dio.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/modals/users/user.dart';

class UserAPIServices {
  final _dio = Dio();

  Future<dynamic> registerUser(User user) async {
    dynamic response;
    try {
      response =
          await _dio.post('$API_BASE_URL/users/register', data: user.toJson());
    } on DioException catch (e) {
      return Future.error({
        "error": "Something went wrong",
        "description": "Error Occurred During ${e.message}"
      });
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

  Future<User?> fetchUserDetails(String email) async {
    User? user;
    try {
      var response =
          await _dio.post("$API_BASE_URL/users/fetch", data: {"email": email});
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
      response =
          await _dio.post("$API_BASE_URL/users/update", data: user.toJson());
    } on DioException catch (err) {
      return Future.error({
        "error": "Something went wrong",
        "description": "Error Occurred During ${err.message}"
      });
    }
    return response.data;
  }
}
