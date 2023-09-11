import 'package:dio/dio.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/modals/jobs/job_table.dart';
import 'package:job_finder/util/text.dart';

class JobAPIServices {
  final _dio = Dio();

  Future<dynamic> createJob(JobTable job) async {
    try {
      var response =
          await _dio.post("$API_BASE_URL/jobs/create", data: job.toJson());

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }
      return response.data;
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
  }

  Future<List<JobTable>> fetchJob(int userID) async {
    List<JobTable> jobs = [];
    try {
      var response = await _dio.get("$API_BASE_URL/jobs/fetch/$userID");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }

      jobs = (response.data['jobs'][0] as List).map((job) {
        return JobTable.fromJson(job);
      }).toList();

      return jobs;
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
  }

  Future<dynamic> deleteJob(String? id) async {
    try {
      var response = await _dio.delete("$API_BASE_URL/jobs/delete/$id");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }
      return response.data;
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
  }

  Future<dynamic> updateJob(JobTable job) async {
    dynamic response;
    try {
      // print("Jod Id is : ${job.id}");
      print("Jod Id is : ${job.toJson()}");
      
      response = await _dio.post("$API_BASE_URL/jobs/update", data: job.toJson());
    } on DioException catch (err) {
      return Future.error({
        "error": err.response!.data['description'],
        "description": err.message
      });
    }

    return response.data;
  }
}
