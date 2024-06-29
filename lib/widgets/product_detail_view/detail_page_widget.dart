import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class DetailPageWidget extends StatelessWidget {
  const DetailPageWidget({
    super.key,
    required this.icon,
    required this.label,
  });
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {},
        style: ButtonStyle(
            side: const WidgetStatePropertyAll(BorderSide(
                width: 2, color: Color.fromARGB(255, 214, 214, 214))),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
            backgroundColor: const WidgetStatePropertyAll(themeWhite)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: icon == Icons.star ? Colors.orange : themeGreen,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: themeBlack,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
