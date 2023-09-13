import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_finder/modals/Errors/error_modal.dart';
import 'package:job_finder/modals/jobs/categories.dart';
import 'package:job_finder/modals/jobs/job_modal_latest.dart';
import 'package:job_finder/modals/jobs/job_table.dart';
import 'package:job_finder/services/api/job_api.dart';

class JobProvider extends ChangeNotifier {
  bool _isSaving = false;
  bool _isDeleting = false;
  bool _hasError = false;
  bool _isLoading = false;
  String _errorMessage = '';
  String _responseMessage = '';

  String get response => _responseMessage;
  String get error => _errorMessage;
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;
  bool get isDeleting => _isDeleting;
  bool get isSaving => _isSaving;
  List<JobTable> jobs = [];
  List<JobOnUserScreen> allJobs = [];
  List<Category> categories = [];

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


  Future updateJob(JobTable job) async {
    // try{
      _isSaving = true;
      notifyListeners();
      var data = await _service.updateJob(job);
      _responseMessage = data['message'];
      log("Response says $data");
    // } on TypeError catch(err) {
    //   var error = ErrorGetter(errorMessage: err.toString(),description: "Type Error occured");
    //   _hasError = true;
    //   _errorMessage = error.errorMessage;
    // } catch (e) {
    //   var error = ErrorGetter.fromJson(e as Map<String, dynamic>);
    //   _hasError = false;
    //   _errorMessage = error.description!;
    // }

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

}
