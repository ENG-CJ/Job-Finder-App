import 'package:dio/dio.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/modals/jobs/categories.dart';
import 'package:job_finder/modals/jobs/job_modal.dart';
import 'package:job_finder/modals/jobs/job_modal_latest.dart';
import 'package:job_finder/modals/jobs/job_table.dart';
import 'package:job_finder/modals/jobs/requestJobs.dart';
import 'package:job_finder/util/categories.dart';

import '../../modals/jobs/requests.dart';

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
        "error": "${e.response} ",
        "description": "error occurred while saving data"
      });
    }
  }

  Future<dynamic> applyJobs(Request data) async {
    try {
      var response =
          await _dio.post("$API_BASE_URL/jobs/applyJob", data: data.toJson());

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
        "error": "${e.message} ${e.response!.data['message']}",
        "description": "error occurred while saving data"
      });
    }
  }

Future<List<JobRequests>> jobRequests(int ownerId) async {
  List<JobRequests> jobs = [];
  try {
    var response = await _dio.get("$API_BASE_URL/jobs/fetchRequest/$ownerId");

    if (response.statusCode != 200) {
      return Future.error({
        "error": "Something gone wrong ${response.statusCode}",
        "description": "There is an error occurred!"
      });
    }

    jobs = (response.data['requests'][0] as List).map((job) {
        return JobRequests.fromJson(job);
      }).toList();
   

    return jobs;
  } on DioException catch (e) {
    return Future.error({
      "error": e.message,
      "description": "Error occurred while saving data"
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

  Future<List<Request>> fetchRequests(int userID) async {
    List<Request> requests = [];
    try {
      var response = await _dio.get("$API_BASE_URL/jobs/requests/$userID");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }

      requests = (response.data['requests'] as List).map((request) {
        return Request.fromJson(request);
      }).toList();

      return requests;
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
  }

  Future<int> getRowsAnalyst(String tableName, int owner_id,
      [String status = '']) async {
    try {
      var response = await _dio.get(
          "$API_BASE_URL/jobs/count?table=$tableName&owner_id=$owner_id&status=$status");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }

      return response.data['numberOfRows'];
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
  }

  Future<bool> hasAlreadyApplied(int userID, String jobID) async {
    bool hasData = false;
    try {
      var response =
          await _dio.get("$API_BASE_URL/jobs/checkRequest/$userID/$jobID");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }

      var data = response.data['jobs'] as List;
      hasData = data.isNotEmpty;
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
    return hasData;
  }

  Future<List<Category>> fetchCategories() async {
    List<Category> categories = [];
    try {
      var response = await _dio.get("$API_BASE_URL/jobs/fetchCategories");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }

      categories = (response.data['categories'] as List).map((category) {
        return Category.fromJson(category);
      }).toList();

      return categories;
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
  }

  Future<List<JobOnUserScreen>> displayJobsOnUserScreen() async {
    List<JobOnUserScreen> jobs = [];
    try {
      var response = await _dio.get("$API_BASE_URL/jobs/");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }

      jobs = (response.data['jobs'] as List)
          .map((json) => JobOnUserScreen.fromJson(json))
          .toList();

      return jobs;
    } on DioException catch (e) {
      return Future.error({
        "error": e.message,
        "description": "error occurred while saving data"
      });
    }
  }

  Future<List<JobOnUserScreen>> displayJobsBasedOnCategory(
      String category) async {
    List<JobOnUserScreen> jobs = [];
    try {
      var response =
          await _dio.get("$API_BASE_URL/jobs/fetchJobsCategory/$category");

      if (response.statusCode != 200) {
        return Future.error({
          "error":
              "Something went wrong the request returned ${response.statusCode}",
          "description": "there is an error for this request please try again"
        });
      }

      jobs = (response.data['jobs'] as List)
          .map((json) => JobOnUserScreen.fromJson(json))
          .toList();

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

  Future<dynamic> deleteRequest(int id, String job_id) async {
    try {
      var response =
          await _dio.delete("$API_BASE_URL/jobs/deleteRequest/$id/$job_id");

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

      response =
          await _dio.post("$API_BASE_URL/jobs/update", data: job.toJson());
    } on DioException catch (err) {
      return Future.error({
        "error": err.response!.data['description'],
        "description": err.message
      });
    }

    return response.data;
  }

  Future<dynamic> updateStatus(int reqId, String status) async{
    dynamic response;
    try{
      response = await _dio.put("$API_BASE_URL/jobs/updateStatus/$reqId/$status");
    } on DioException catch (error) {
      return Future.error({
        "error": error.response!.data['description'],
        "description": error.message
      });
    }
    return response.data;
  }

}
