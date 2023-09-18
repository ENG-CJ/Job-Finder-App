import 'package:flutter/material.dart';
import 'package:job_finder/modals/Errors/error_modal.dart';
import 'package:job_finder/services/api/users_api.dart';

import '../../modals/users/user.dart';

class UserProvider extends ChangeNotifier {
  bool _isSaving = false;
  bool _profile_loading = false;
  bool _hasError = false;
  String _errorMessage = '';
  String _description = '';
  String _responseMessage = '';
  User? _userData;

  String get response => _responseMessage;
  String get error => _errorMessage;
  String get description => _description;
  bool get hasError => _hasError;
  bool get isSaving => _isSaving;
  bool get profileLoading => _profile_loading;
  User? get user => _userData;
  final _user = UserAPIServices();

  set isSaving(bool saving) {
    _isSaving = saving;
    notifyListeners();
  }

  Future createUser(User user) async {
    try {
      _isSaving = true;
      notifyListeners();
      var data = await _user.registerUser(user);
      _responseMessage = data['message'];
    } on TypeError catch (e) {
      var error = ErrorGetter(
          errorMessage: e.toString(), description: "Type Error Occurred");
      _hasError = true;
      _errorMessage = error.errorMessage;
      print("error says ${error.errorMessage}");
    } catch (e) {
      var error = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _hasError = true;
      _errorMessage = error.description!;
      print("error says ${error.errorMessage}");
    }

    _isSaving = false;
    notifyListeners();
  }

  Future login(Map<String, dynamic> data) async {
    _isSaving = true;
    notifyListeners();
    var authLoginStatus = await _user.getUserWithCredentials(data);
    authLoginStatus.fold((error) {
      _errorMessage = error.errorMessage;
      _description = error.description!;
      _hasError = true;
    }, (success) {
      _hasError = false;
      _userData = success;
    });

    _isSaving = false;
    notifyListeners();
  }

  Future fetchUser(int id) async {
    _profile_loading = true;
    notifyListeners();
    _userData = await _user.fetchUserDetails(id);
    _profile_loading = false;
    notifyListeners();
  }

  Future updateUser(User user) async {
    try {
      _isSaving = true;
      notifyListeners();
      var data = await _user.updateUser(user);
      _responseMessage = data['message'];
      print("response says $data");
    } on TypeError catch (err) {
      var error = ErrorGetter(
          errorMessage: err.toString(), description: "Type Error occured");
      _hasError = true;
      _errorMessage = error.errorMessage;
    } catch (e) {
      var error = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _hasError = true;
      _errorMessage = error.description!;
    }

    _isSaving = false;
    notifyListeners();
  }
}
