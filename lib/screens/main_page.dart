import 'package:ecommerce_app/screens/favorites_view.dart';
import 'package:ecommerce_app/screens/home_view.dart';
import 'package:ecommerce_app/screens/profile_view.dart';
import 'package:ecommerce_app/screens/search_view.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/main_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/main_page/buttom_bar_item.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeWhite,
      bottomNavigationBar: _createCustomButtomNavigationBar(),
      body: IndexedStack(
        index: Provider.of<MainPageViewModel>(context).activePageId,
        children: const [
          HomeView(),
          SeachView(),
          FavoritesView(),
          ProfileView(),
        ],
      ),
    );
  }

  Container _createCustomButtomNavigationBar() {
    return Container(
      padding: const EdgeInsets.only(
          top: 7, left: defaultPadding * 1.4, right: defaultPadding * 1.4),
      color: themeWhite,
      height: 9.h,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtomBarItem(
            pageId: 0,
            icon: Icons.home,
            label: "Home",
          ),
          ButtomBarItem(
            pageId: 1,
            icon: CupertinoIcons.search,
            label: "Search",
          ),
          ButtomBarItem(
            pageId: 2,
            icon: Icons.favorite_border_outlined,
            label: "Favorites",
          ),
          ButtomBarItem(
            pageId: 3,
            icon: Icons.person_2_outlined,
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
