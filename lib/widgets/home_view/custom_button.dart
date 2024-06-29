import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.function,
  });
  final IconData icon;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: function,
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 232, 232, 232), width: 3),
            color: themeWhite,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Icon(
            icon,
            size: 15.sp,
          ),
        ),
      ),
    );
  }
}
