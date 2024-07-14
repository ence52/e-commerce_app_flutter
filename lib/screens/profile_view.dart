import 'package:ecommerce_app/screens/login_view.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                context.read<UserService>().logout();
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
