import 'package:ecommerce_app/screens/home_view/home_view.dart';
import 'package:ecommerce_app/utils/theme.dart';
import 'package:ecommerce_app/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',
          theme: theme,
          home: const HomeView(),
        ),
      );
    });
  }
}
