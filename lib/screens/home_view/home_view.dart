import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/home_view_model.dart';
import 'package:ecommerce_app/widgets/home_view/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/home_view/custom_button.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeWhite,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Discover",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    _createCartButton()
                  ],
                ),
              ),
              SizedBox(
                height: 80.h,
                child: Consumer<HomeViewModel>(
                  builder: (context, homeViewModel, child) {
                    if (homeViewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (homeViewModel.products.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Her satırda iki ürün
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: 4 / 5, // Kartların en-boy oranı
                      ),
                      itemCount: homeViewModel.products.length,
                      itemBuilder: (context, index) {
                        return ItemCard(product: homeViewModel.products[index]);
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  Stack _createCartButton() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        const Padding(
          padding: EdgeInsets.all(2),
          child: CustomButton(
            icon: Icons.shopping_bag_outlined,
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
