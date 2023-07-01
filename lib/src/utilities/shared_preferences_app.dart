import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApp {
  static String valueSharedPreferences = '';

  static Future<void> setId(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("id", value);
  }

  static Future<String> getId(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

// Thêm các phương thức khác tùy theo nhu cầu của bạn
}