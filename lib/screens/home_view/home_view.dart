import 'package:ecommerce_app/screens/cart_view/cart_view.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../view_models/home_view_model.dart';
import '../../widgets/home_view/category_button_widget.dart';
import '../../widgets/home_view/custom_button.dart';
import '../../widgets/home_view/item_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // HomeViewModel'i al ve fetchProducts çağır
    Future.microtask(() {
      Provider.of<HomeViewModel>(context, listen: false).fetchProducts();
    });
    Future.microtask(() {
      Provider.of<HomeViewModel>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _createTitleSection(),
          _createSearchBar(),
          const SizedBox(
            height: 20,
          ),
          _createAdSection(),
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
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          _createCartButton(),
        ],
      ),
    );
  }

  Container _createAdSection() {
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

  Expanded _createProductsGrid() {
    return Expanded(
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          if (homeViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            cacheExtent: 2000,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Her satırda iki ürün
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              childAspectRatio: 4 / 5, // Kartların en-boy oranı
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
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: CustomButton(
            icon: Icons.shopping_bag_outlined,
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
              "3",
              style: TextStyle(color: themeWhite, fontSize: 8.sp),
            ),
          ),
        )
      ],
    );
  }
}
