import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_finder/modals/Errors/error_modal.dart';
import 'package:job_finder/modals/jobs/categories.dart';
import 'package:job_finder/modals/jobs/job_modal_latest.dart';
import 'package:job_finder/modals/jobs/job_table.dart';
import 'package:job_finder/modals/jobs/requestJobs.dart';
import 'package:job_finder/services/api/job_api.dart';

import '../../modals/jobs/requests.dart';

class JobProvider extends ChangeNotifier {
  bool _isSaving = false;
  bool _isDeleting = false;
  bool _hasError = false;
  bool _isLoading = false;
  bool _isValidData = false;
  bool _dashboardLoading = false;
  String _errorMessage = '';
  String _responseMessage = '';

  String get response => _responseMessage;
  String get error => _errorMessage;
  bool get isValidData => _isValidData;
  bool get dashboardLoading => _dashboardLoading;
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;
  bool get isDeleting => _isDeleting;
  bool get isSaving => _isSaving;
  int jobsRow = 0;
  int requestsRow = 0;
  int rejectedRow = 0;
  int acceptedRow = 0;
  int pendingRow = 0;
  List<JobTable> jobs = [];
  List<Request> requests = [];
  List<JobOnUserScreen> allJobs = [];
  List<JobOnUserScreen> jobsBasedOnCategory = [];
  List<Category> categories = [];
  List<JobRequests> requestedJobs = [];

  var _service = JobAPIServices();

  Future saveJobData(JobTable job) async {
    try {
      _isSaving = true;
      notifyListeners();

      var response = await _service.createJob(job);
      _responseMessage = response['message'];
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.stackTrace.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _hasError = true;
      _errorMessage = _formater.errorMessage;
    }

    _isSaving = false;
    notifyListeners();
  }

  Future applyJobsData(Request data) async {
    try {
      _isSaving = true;
      notifyListeners();

      var response = await _service.applyJobs(data);
      _responseMessage = response['message'];
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.stackTrace.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _hasError = true;
      _errorMessage = _formater.errorMessage;
    }

    _isSaving = false;
    notifyListeners();
  }

  Future deleteJobData(String? id) async {
    try {
      _isDeleting = true;
      notifyListeners();
      var response = await _service.deleteJob(id);
      _responseMessage = response['message'];
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.stackTrace.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
    }

    _isDeleting = false;
    notifyListeners();
  }

  Future deleteRequest(int id, String job_id) async {
    try {
      _isDeleting = true;
      notifyListeners();

      var response = await _service.deleteRequest(id, job_id);
      _responseMessage = response['message'];
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.stackTrace.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
    }

    _isDeleting = false;
    notifyListeners();
  }

  Future hasData(int user, String job_id) async {
    try {
      var response = await _service.hasAlreadyApplied(user, job_id);
      _isValidData = response;
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.stackTrace.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
    }
    notifyListeners();
  }

  Future<void> fetchJobs(int id) async {
    try {
      _isLoading = true;
      notifyListeners();
      jobs = await _service.fetchJob(id);
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      _hasError = true;
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _errorMessage = _formater.errorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> jobRequest(int ownerId) async {
    try {
      _isLoading = true;
      notifyListeners();
      requestedJobs = await _service.jobRequests(ownerId);
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      print(e);
      // _hasError = true;
      // var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      // _errorMessage = _formater.errorMessage;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getRowCount(Map<String, dynamic> data) async {
    try {
      _dashboardLoading = true;
      notifyListeners();
      switch (data['table']) {
        case 'jobs':
          jobsRow = await _service.getRowsAnalyst(data['table'], data['owner']);
          break;

        case 'requests':
          requestsRow =
              await _service.getRowsAnalyst(data['table'], data['owner']);
          break;
        case 'rejectedRequests':
          rejectedRow = await _service.getRowsAnalyst(
              data['table'], data['owner'], data['status']);
          break;
        case 'acceptedRequests':
          acceptedRow = await _service.getRowsAnalyst(
              data['table'], data['owner'], data['status']);
          break;
        case 'pendingRequests':
          pendingRow = await _service.getRowsAnalyst(
              data['table'], data['owner'], data['status']);
          break;
        default:
      }
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      _hasError = true;
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _errorMessage = _formater.errorMessage;
    }

    _dashboardLoading = false;
    notifyListeners();
  }

  Future<void> fetchRequests(int id) async {
    try {
      _isLoading = true;
      notifyListeners();
      requests = await _service.fetchRequests(id);
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      _hasError = true;
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _errorMessage = _formater.errorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future updateStatus(int reqId, String status) async {
    try {
      _isSaving = true;
      _isLoading = true;
      notifyListeners();
      var response = await _service.updateStatus(reqId, status);
    } on TypeError catch (err) {
      var error = ErrorGetter(
          errorMessage: err.toString(), description: "Type Error occured");
      _hasError = true;
      _errorMessage = error.errorMessage;
    } catch (e) {
      var error = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _hasError = false;
      _errorMessage = error.description!;
    }
    _isSaving = false;
    _isLoading = false;
    notifyListeners();
  }

  Future updateJob(JobTable job) async {
    try {
      _isSaving = true;
      notifyListeners();
      var data = await _service.updateJob(job);
      _responseMessage = data['message'];
      log("Response says $data");
    } on TypeError catch (err) {
      var error = ErrorGetter(
          errorMessage: err.toString(), description: "Type Error occured");
      _hasError = true;
      _errorMessage = error.errorMessage;
    } catch (e) {
      var error = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _hasError = false;
      _errorMessage = error.description!;
    }

    _isSaving = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();
      categories = await _service.fetchCategories();
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      _hasError = true;
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _errorMessage = _formater.errorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAllJobs() async {
    try {
      _hasError = false;
      _isLoading = true;
      notifyListeners();
      allJobs = await _service.displayJobsOnUserScreen();
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      _hasError = true;
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _errorMessage = _formater.errorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getJobsBasedOnCategories(String category) async {
    try {
      jobsBasedOnCategory = await _service.displayJobsBasedOnCategory(category);
    } on TypeError catch (e) {
      var formatter = ErrorGetter(
          errorMessage: e.toString(),
          description: "This error was type error please check your data");
      _hasError = true;
      _errorMessage = formatter.errorMessage;
    } catch (e) {
      _hasError = true;
      var _formater = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _errorMessage = _formater.errorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }
}
