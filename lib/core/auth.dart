import 'package:ecommerce_app/core/shared_prefs.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  String? getToken() {
    return SharedPrefs().prefs?.getString("token");
  }

  void setToken(String token) {
    SharedPrefs().prefs?.setString("token", token);
  }

  void clearToken() {
    SharedPrefs().prefs?.remove("token");
  }
}
