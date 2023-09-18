import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkProvider extends ChangeNotifier {
  bool _hasConnection = false;
  bool _searchConnectivity = false;
  String _lastTryError = '';

  void setHasConnection(bool value) {
    _hasConnection = value;
    notifyListeners();
  }

  bool get hasConnection => _hasConnection;
  bool get searchConnectivity => _searchConnectivity;

  void setSearchConnectivity(bool value) {
    _searchConnectivity = value;
    notifyListeners();
  }

  void setLastTryError(String value) {
    _lastTryError = value;
    notifyListeners();
  }

  String get lastTryError => _lastTryError;

  void clear() {
    _hasConnection = false;
    _lastTryError = '';
    notifyListeners();
  }

  Future<void> checkConnection(BuildContext? context) async {
    try {
      _searchConnectivity = true;
      await Future.delayed(Duration(seconds: 5));
      _hasConnection = await InternetConnectionChecker().hasConnection;
    } on SocketException catch (e) {
      setHasConnection(false);
      _lastTryError = e.message;
    } catch (e) {
      setHasConnection(false);
      _lastTryError = e.toString();
    }
    _searchConnectivity = false;
    notifyListeners();
  }
}
