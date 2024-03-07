import 'package:hophseeflutter/core/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static putDataInt(String key, int? value) async {
    if (value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(key, value);
    }
  }

  static putDataBool(String key, bool? value) async {
    if (value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(key, value);
    }
  }

  static putDataDouble(String key, double? value) async {
    if (value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble(key, value);
    }
  }

  static putDataString(String key, String? value) async {
    if (value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }
  }

  static putDataStringList(String key, List<String>? value) async {
    if (value != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(key, value);
    }
  }

  static putDataUserDetails(String? name, String? imageUrl, int? id,
      {bool isDoctor = false}) async {
    if (name != null && id != null && imageUrl != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(isDoctor ? DOCTOR_ID_PREFERENCE : USER_ID_PREFERENCE, id);
      prefs.setString(NAME_PREFERENCE, name);
      prefs.setString(IMAGE_URL_PREFERENCE, "$host/$imageUrl");
      prefs.setBool(IS_DOCTOR_PREFERENCE, isDoctor);
    }
  }

  static Future<dynamic> getValueFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future<Map<String, String?>>
      getUserDetailsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String?> data = {};
    data["name"] = prefs.getString(NAME_PREFERENCE);
    data["image_url"] = prefs.getString(IMAGE_URL_PREFERENCE);
    return data;
  }

  static Future<dynamic> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(DOCTOR_ID_PREFERENCE);
    prefs.remove(USER_ID_PREFERENCE);
    prefs.remove(NAME_PREFERENCE);
    prefs.remove(IMAGE_URL_PREFERENCE);
    prefs.remove(IS_DOCTOR_PREFERENCE);
  }

  static Future<Map<String, dynamic>> getLoginConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? doctorId = prefs.getInt(DOCTOR_ID_PREFERENCE);
    int? userId = prefs.getInt(USER_ID_PREFERENCE);
    bool? isDoctor = prefs.getBool(IS_DOCTOR_PREFERENCE);

    bool isLogin = (doctorId != null) || (userId != null);
    Map<String, dynamic> data = {};
    data[IS_LOGIN_PREFERENCE] = isLogin;
    data[IS_DOCTOR_PREFERENCE] = isDoctor;
    return data;
  }
}
