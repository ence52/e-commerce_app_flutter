import 'package:ecommerce_app/screens/register_view/register_view.dart';
import 'package:ecommerce_app/utils/theme.dart';
import 'package:ecommerce_app/view_models/cart_view_model.dart';
import 'package:ecommerce_app/view_models/home_view_model.dart';
import 'package:ecommerce_app/view_models/main_page_view_model.dart';
import 'package:ecommerce_app/view_models/product_detail_view_model.dart';
import 'package:ecommerce_app/view_models/register_view_model.dart';
import 'package:ecommerce_app/view_models/search_view_model.dart';
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
          ChangeNotifierProvider(
            create: (_) => HomeViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => MainPageViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => ProductDetailViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => CartViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => RegisterViewModel(),
          ),
        ],
        child: MaterialApp(
          scrollBehavior: const ScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',
          theme: theme,
          home: const RegisterView(),
        ),
      );
    });
  }
}
