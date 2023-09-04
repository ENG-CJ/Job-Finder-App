import 'package:flutter/material.dart';
import 'package:job_finder/modals/Errors/error_modal.dart';
import 'package:job_finder/services/api/users_api.dart';

import '../../modals/users/user.dart';

class UserProvider extends ChangeNotifier {
  bool _isSaving = false;
  bool _profile_loadig = false;
  bool _hasError = false;
  String _errorMessage = '';
  String _responseMessage = '';
  User? _userData;

  String get response => _responseMessage;
  String get error => _errorMessage;
  bool get hasError => _hasError;
  bool get isSaving => _isSaving;
  bool get profileLoading => _profile_loadig;
  User? get user => _userData;
  final _user = UserAPIServices();

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
    } catch (e) {
      var error = ErrorGetter.fromJson(e as Map<String, dynamic>);
      _hasError = true;
      _errorMessage = error.description!;
    }

    _isSaving = false;
    notifyListeners();
  }

  Future login(Map<String, dynamic> data) async {
    _isSaving = true;
    notifyListeners();
    _userData = await _user.getUserWithCredentials(data);

    _isSaving = false;
    notifyListeners();
  }

  Future fetchUser(String email) async {
    _profile_loadig = true;
    notifyListeners();
    _userData = await _user.fetchUserDetails(email);
    _profile_loadig = false;
    notifyListeners();
  }
}
