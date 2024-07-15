import 'package:ecommerce_app/core/auth.dart';
import 'package:ecommerce_app/screens/login_view.dart';
import 'package:ecommerce_app/screens/main_page.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:ecommerce_app/utils/theme.dart';
import 'package:ecommerce_app/view_models/cart_view_model.dart';
import 'package:ecommerce_app/view_models/favorites_view_model.dart';
import 'package:ecommerce_app/view_models/home_view_model.dart';
import 'package:ecommerce_app/view_models/login_view_model.dart';
import 'package:ecommerce_app/view_models/main_page_view_model.dart';
import 'package:ecommerce_app/view_models/product_detail_view_model.dart';
import 'package:ecommerce_app/view_models/register_view_model.dart';
import 'package:ecommerce_app/view_models/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'core/shared_prefs.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SharedPrefs().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          Provider<UserService>(
            create: (_) => UserService(),
          ),
          ChangeNotifierProxyProvider<UserService, CartViewModel>(
            create: (context) => CartViewModel(
                Provider.of<UserService>(context, listen: false).user),
            update: (context, userService, cartViewModel) =>
                cartViewModel!..updateUser(userService.user),
          ),
          ChangeNotifierProxyProvider<UserService, FavoritesViewModel>(
            create: (context) => FavoritesViewModel(
                Provider.of<UserService>(context, listen: false).user),
            update: (context, userService, favoriteViewModel) =>
                favoriteViewModel!..updateUser(userService.user),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => RegisterViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => LoginViewModel(),
          ),
        ],
        child: MaterialApp(
          scrollBehavior: const ScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',
          theme: theme,
          home: FutureBuilder<bool>(
            future: _checkToken(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Text('Connection Problem'),
                  ),
                );
              } else {
                if (snapshot.data == true) {
                  FlutterNativeSplash.remove();
                  return const MainPageView();
                } else {
                  FlutterNativeSplash.remove();
                  return const LoginView();
                }
              }
            },
          ),
        ),
      );
    });
  }

  Future<bool> _checkToken() async {
    String? token = AuthService().getToken();
    bool test = await UserService().testToken();
    if (token != null && token.isNotEmpty && test) {
      return true;
    } else {
      return false;
    }
  }
}
