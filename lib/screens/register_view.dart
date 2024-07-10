import 'package:ecommerce_app/screens/login_view.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: themeGrey,
      body: Padding(
        padding: EdgeInsets.all(defaultPadding * 2),
        child: Center(
          child: _RegisterForm(),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
      builder: (context, registerViewModel, child) {
        return Form(
            key: registerViewModel.formKey,
            child: Wrap(
              runSpacing: 20,
              children: <Widget>[
                Text(
                  "Register",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) => registerViewModel.validateName(value),
                  style: TextStyle(fontSize: 12.sp),
                  controller: registerViewModel.nameController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 8.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: themeTextFieldGrey,
                    label: const Text("Name"),
                    hintText: "Name",
                  ),
                ),
                TextFormField(
                  validator: (value) => registerViewModel.validateEmail(value),
                  style: TextStyle(fontSize: 12.sp),
                  controller: registerViewModel.emailController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 8.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: themeTextFieldGrey,
                    label: const Text("E-mail"),
                    hintText: "E-mail",
                  ),
                ),
                TextFormField(
                  validator: (value) =>
                      registerViewModel.validatePassword(value),
                  style: TextStyle(fontSize: 12.sp),
                  obscureText: true,
                  controller: registerViewModel.passwordController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 8.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: themeTextFieldGrey,
                    label: const Text("Password"),
                    hintText: "Password",
                  ),
                ),
                TextFormField(
                  validator: (value) =>
                      registerViewModel.validateConfirmPassword(value),
                  style: TextStyle(fontSize: 12.sp),
                  obscureText: true,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 8.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: themeTextFieldGrey,
                    label: const Text("Confirm Password"),
                    hintText: "Confirm Password",
                  ),
                ),
                const ConfirmButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: themeBlack,
                              fontSize: 11.sp,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                )
              ],
            ));
      },
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: OutlinedButton(
          onPressed: () async {
            if (registerViewModel.formKey.currentState?.validate() ?? false) {
              await registerViewModel.createUser();
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
