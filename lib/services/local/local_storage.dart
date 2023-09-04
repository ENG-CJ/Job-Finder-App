import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// shared pref that stores all user sessions and local data
class LocalStorageSharedPref {
  late SharedPreferences _sharedPreferences;

  Future initLocalStorage() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future storeUserDetails(Map<String, dynamic> userLocalData) async {
    await initLocalStorage();
    await _sharedPreferences.setString("userData", jsonEncode(userLocalData));
  }

  Future<Map<String, dynamic>?> getLocalData() async {
    await initLocalStorage();
    var data = _sharedPreferences.getString("userData");
    if (data != null) return jsonDecode(data);

    return null;
  }

  /// Removes data from local space, based on specified key
  Future removeLocalData(String key) async {
    await initLocalStorage();
    _sharedPreferences.remove(key);
  }
}
