import 'package:ecommerce_app/screens/main_page.dart';
import 'package:ecommerce_app/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: themeGrey,
      body: Padding(
        padding: EdgeInsets.all(defaultPadding * 2),
        child: Center(
          child: _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, loginViewModel, child) {
        return Form(
            key: loginViewModel.formKey,
            child: Wrap(
              runSpacing: 20,
              children: <Widget>[
                Text(
                  "Login",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) => loginViewModel.validateEmail(value),
                  style: TextStyle(fontSize: 12.sp),
                  controller: loginViewModel.emailController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 8.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: themeTextFieldGrey,
                    label: const Text("E-mail"),
                    hintText: "E-mail",
                  ),
                ),
                TextFormField(
                  validator: (value) => loginViewModel.validatePassword(value),
                  style: TextStyle(fontSize: 12.sp),
                  obscureText: true,
                  controller: loginViewModel.passwordController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 8.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: themeTextFieldGrey,
                    label: const Text("Password"),
                    hintText: "Password",
                  ),
                ),
                const LoginConfirmButton()
              ],
            ));
      },
    );
  }
}

class LoginConfirmButton extends StatelessWidget {
  const LoginConfirmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: OutlinedButton(
          onPressed: () async {
            if (loginViewModel.formKey.currentState?.validate() ?? false) {
              var result = await loginViewModel.login();
              if (result == true) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPageView(),
                    ));
              }
            }
          },
          style: ButtonStyle(
              side: const WidgetStatePropertyAll(BorderSide.none),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              backgroundColor: const WidgetStatePropertyAll(themeGreen)),
          child: Text(
            "Confirm",
            style: TextStyle(
                fontSize: 12.sp,
                color: themeWhite,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
