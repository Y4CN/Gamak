import 'package:game_hacks_chat/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareManager {
  ShareManager._();
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('token', token);
  }

  static String readAuth() {
    return _sharedPref.getString('token') ?? '';
  }

  static void logout() {
    _sharedPref.clear();
  }

  static bool isLogedin() {
    String token = readAuth();
    return token.isNotEmpty;
  }

  static saveUserId(String userId) {
    _sharedPref.setString('userId', userId);
  }

  static String readUserId() {
    return _sharedPref.getString('userId') ?? '';
  }
}