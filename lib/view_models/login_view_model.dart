import 'package:ecommerce_app/models/user_login_model.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';

class LoginViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool get isLoading => _isLoading;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  Future<bool> login() async {
    UserLoginModel user = UserLoginModel(
      username: emailController.text,
      password: passwordController.text,
    );

    try {
      _isLoading = true;
      notifyListeners();
      bool result = await _userService.login(user);
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
