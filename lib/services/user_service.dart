import 'dart:convert';
import 'package:ecommerce_app/core/auth.dart';
import 'package:ecommerce_app/core/shared_prefs.dart';
import 'package:ecommerce_app/models/user_info.dart';
import 'package:ecommerce_app/models/user_login_model.dart';
import 'package:ecommerce_app/models/user_register_model.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  UserInfoModel? user;

  Future<User> createUser(User user) async {
    var url = Uri.parse(
      '$API_BASE_URL/users/',
    );
    var response = await http.post(
      url,
      body: jsonEncode(user.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      User createdUser = data.map((json) => User.fromJson(json));
      return createdUser;
    } else {
      throw Exception("Failed to create User");
    }
  }

  Future<bool> login(UserLoginModel user) async {
    var url = Uri.parse(
      '$API_BASE_URL/users/token',
    );
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var body = user.toJson();

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      AuthService().setToken(data["access_token"]);
      await testToken();
      return true;
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<void> logout() async {
    SharedPrefs().prefs?.setString("token", "");
    UserService().user = null;
  }

  Future<bool> testToken() async {
    final token = AuthService().getToken();
    final url = Uri.parse('$API_BASE_URL/users/info');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      user = UserInfoModel.fromJson(data);
      return true;
    } else {
      return false;
    }
  }
}
