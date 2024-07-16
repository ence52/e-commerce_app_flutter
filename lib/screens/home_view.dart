import 'package:ecommerce_app/screens/cart_view.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/cart_view_model.dart';
import 'package:ecommerce_app/view_models/favorites_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../view_models/home_view_model.dart';
import '../widgets/home_view/category_button_widget.dart';
import '../widgets/home_view/custom_button.dart';
import '../widgets/home_view/item_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<HomeViewModel>(context, listen: false).fetchProducts();
    });
    Future.microtask(() {
      Provider.of<HomeViewModel>(context, listen: false).fetchCategories();
    });

    Future.microtask(() {
      Provider.of<CartViewModel>(context, listen: false).fetchProducts();
    });
    Future.microtask(() {
      Provider.of<CartViewModel>(context, listen: false).getItemCount();
    });
    Future.microtask(() {
      Provider.of<FavoritesViewModel>(context, listen: false).fetchFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _createTitleSection(),
          _createSearchBar(),
          const SizedBox(
            height: 20,
          ),
          const _AdSection(),
          const SizedBox(
            height: 20,
          ),
          _createCategoriesAndSeeAllText(),
          _createCategoryButtons(),
          const SizedBox(
            height: 10,
          ),
          _createProductsGrid()
        ],
      ),
    );
  }

  Padding _createTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding * 0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Discover",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          _createCartButton(),
        ],
      ),
    );
  }

  Padding _createSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                CupertinoIcons.search,
                size: 18.sp,
              ),
            )),
      ),
    );
  }

  Padding _createCategoriesAndSeeAllText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            "See All",
            style: TextStyle(
                fontSize: 12.sp,
                color: themeGreen,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  SizedBox _createCategoryButtons() {
    return SizedBox(
        height: 60,
        child: Consumer<HomeViewModel>(
          builder: (context, homeViewModel, child) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeViewModel.categories.length,
                itemBuilder: (context, index) => Row(
                      children: [
                        if (index != 0)
                          const SizedBox(width: 10.0)
                        else
                          const SizedBox(width: defaultPadding),
                        CategoryButtonWidget(
                            category: homeViewModel.categories[index]),
                        if (index == homeViewModel.categories.length - 1)
                          const SizedBox(width: defaultPadding)
                      ],
                    ));
          },
        ));
  }

  SizedBox _createProductsGrid() {
    return SizedBox(
      height: 76.h,
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return GridView.builder(
            physics: const ClampingScrollPhysics(),
            cacheExtent: 2000,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              childAspectRatio: 4 / 5,
            ),
            itemCount: homeViewModel.products.length,
            itemBuilder: (context, index) {
              return ItemCard(product: homeViewModel.products[index]);
            },
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          );
        },
      ),
    );
  }

  Stack _createCartButton() {
    int itemCount = Provider.of<CartViewModel>(context, listen: true).itemCount;
    bool isActive =
        Provider.of<CartViewModel>(context, listen: true).products.isNotEmpty;
    return isActive
        ? Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: CustomButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartView(),
                        ));
                  },
                ),
              ),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    border: Border.all(color: themeGrey, width: 2),
                    color: themeGreen,
                    borderRadius: BorderRadius.circular(15)),
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "$itemCount",
                    style: TextStyle(color: themeWhite, fontSize: 8.sp),
                  ),
                ),
              )
            ],
          )
        : const Stack();
  }
}

class _AdSection extends StatefulWidget {
  const _AdSection();

  @override
  State<_AdSection> createState() => _AdSectionState();
}

class _AdSectionState extends State<_AdSection> {
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      SizedBox(
        height: 200,
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              activePage = value;
            });
          },
          itemCount: 3,
          itemBuilder: (context, index) => const _AddContainer(),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 1.w,
            width: 5.w,
            decoration: BoxDecoration(
                color: index == activePage ? themeWhite : themeLightGreen,
                shape: BoxShape.rectangle),
          ),
        ),
      )
    ]);
  }
}

class _AddContainer extends StatelessWidget {
  const _AddContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          color: themeGreen, borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding * 0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Clearence\nSales",
                  style: TextStyle(
                      height: 1,
                      color: themeWhite,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 45,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: themeWhite),
                  child: Center(
                    child: Text(
                      "Up to %50",
                      style: TextStyle(
                          color: themeGreen,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 1,
              widthFactor: 2.5,
              child: Transform.scale(
                scale: 2,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/ip15.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
