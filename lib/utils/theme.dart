import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData theme = ThemeData(
    fontFamily: "SfProDisplay",
    scaffoldBackgroundColor: themeWhite,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none, // Varsayılan olarak kenarlığı kaldır
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none, // Etkin durumdaki kenarlık rengi
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none, // Odaklanmış durumdaki kenarlık rengi
        ),
        filled: true,
        fillColor: themeGrey,
        contentPadding: const EdgeInsets.only(left: 20, bottom: 16, top: 16),
        hintStyle: TextStyle(
            color: const Color.fromARGB(118, 42, 42, 42),
            fontWeight: FontWeight.bold,
            fontSize: 12.sp)));
