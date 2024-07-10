import 'package:ecommerce_app/screens/favorites_view.dart';
import 'package:ecommerce_app/screens/home_view.dart';
import 'package:ecommerce_app/screens/profile_view.dart';
import 'package:ecommerce_app/screens/search_view.dart';
import 'package:flutter/cupertino.dart';

class MainPageViewModel extends ChangeNotifier {
  int _activePageId = 0;
  final List<Widget> _pages = [
    const HomeView(),
    const SeachView(),
    const FavoritesView(),
    const ProfileView()
  ];

  int get activePageId => _activePageId;
  Widget get activePage => _pages[activePageId];

  void changeActivePage(int categoryId) {
    _activePageId = categoryId;
    notifyListeners();
  }
}
