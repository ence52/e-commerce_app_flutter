import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {},
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
            border: Border.all(color: themeGrey, width: 3),
            color: themeWhite,
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          icon,
          size: 16.sp,
        ),
      ),
    );
  }
}
