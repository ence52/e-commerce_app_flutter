import 'package:ecommerce_app/core/shared_prefs.dart';
import 'package:ecommerce_app/screens/login_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 100,
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                SharedPrefs().prefs?.setString("token", "");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ));
              },
              child: const Text("Log Out"))),
    );
  }
}
