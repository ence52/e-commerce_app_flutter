import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData theme = ThemeData(
  useMaterial3: false,
  fontFamily: "SfProDisplay",
  scaffoldBackgroundColor: themeWhite,
  appBarTheme: const AppBarTheme(color: themeWhite),
  inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: themeTextGrey,
      iconColor: themeBlack,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: themeGrey,
      contentPadding: const EdgeInsets.only(left: 20, bottom: 16, top: 16),
      hintStyle: TextStyle(
          color: const Color.fromARGB(118, 42, 42, 42),
          fontWeight: FontWeight.bold,
          fontSize: 12.sp),
      labelStyle: TextStyle(
          color: const Color.fromARGB(118, 42, 42, 42),
          fontWeight: FontWeight.bold,
          fontSize: 12.sp)),
);
