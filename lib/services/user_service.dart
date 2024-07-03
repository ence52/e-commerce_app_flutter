import 'dart:convert';

import 'package:ecommerce_app/models/user_register_model.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserService {
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
}
