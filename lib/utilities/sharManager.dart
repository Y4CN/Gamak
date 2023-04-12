import 'package:game_hacks_chat/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareManager {
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logout() {
    _sharedPref.clear();
  }

  static bool isLogedin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}