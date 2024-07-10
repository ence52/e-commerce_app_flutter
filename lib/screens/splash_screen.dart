import 'package:ecommerce_app/core/shared_prefs.dart';
import 'package:ecommerce_app/screens/login_view.dart';
import 'package:ecommerce_app/screens/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  _checkToken() async {
    String? token = SharedPrefs().prefs?.getString("token");

    if (token!.isNotEmpty) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPageView(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
    );
  }
}
