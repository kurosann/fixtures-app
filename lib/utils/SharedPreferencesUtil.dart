import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {


  static dynamic getData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static void putData(String key, String value) async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(key, value);
  }
}
