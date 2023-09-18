import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:job_finder/config/dio_config.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/modals/Errors/error_modal.dart';
import 'package:job_finder/modals/users/user.dart';

class UserAPIServices {
  final _dio = DioConfiguration.createRequest();

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

  Future<Either<ErrorGetter, User?>> getUserWithCredentials(
      Map<String, dynamic> data) async {
    User? user;
    try {
      var response = await _dio.post("$API_BASE_URL/users/login", data: data);
      if (response.statusCode != 200) {
        throw DioException(
            requestOptions: RequestOptions(baseUrl: API_BASE_URL),
            response: response);
      }

      if (response.data['userData'].length > 0) {
        user = User.fromJson((response.data['userData'] as List).first);
      } else {
        return right(null);
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          var error = ErrorGetter(
              errorMessage: e.message!,
              description: "Bad Response Error Occured");
          return Left(error);
        case DioExceptionType.connectionTimeout:
          var error = ErrorGetter(
              errorMessage: "The Connection has timed out",
              description:
                  "the server is taking to long to respond, Try Again");
          return Left(error);

        case DioExceptionType.receiveTimeout:
          var error = ErrorGetter(
              errorMessage: "The Received Data has timed out",
              description:
                  "the server is taking to long to retrieve data, please reload");
          return Left(error);

        case DioExceptionType.unknown:
          var error = ErrorGetter(
              errorMessage: "Unknown Error Occurred",
              description:
                  "The server returned unknown Error ${e.response!.statusCode}");
          return Left(error);

        default:
          var error = ErrorGetter(
              errorMessage: "Unknown Error Occurred ${e.response!.statusCode}",
              description: "The server returned unknown Error");
          return Left(error);
      }
    }

    return right(user);
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
