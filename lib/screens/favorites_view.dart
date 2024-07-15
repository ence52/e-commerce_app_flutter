import 'package:ecommerce_app/models/product_favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';
import '../view_models/favorites_view_model.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: themeGrey,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding * 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Favorites",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Consumer<FavoritesViewModel>(
                    builder: (context, favoritesViewModel, child) {
                      return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => _FavoritesCard(
                                product: favoritesViewModel.favorites[index],
                              ),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: favoritesViewModel.favorites.length);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoritesCard extends StatelessWidget {
  const _FavoritesCard({
    required this.product,
  });
  final ProductFavoriteModel product;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4,
      child: Container(
          decoration: BoxDecoration(
              color: themeLightGreen, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                    fit: BoxFit.cover, "${product.images![0].url}"),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.name}",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              AspectRatio(
                  aspectRatio: 1,
                  child: IconButton(
                      color: themeBlack,
                      onPressed: () async {
                        await Provider.of<FavoritesViewModel>(context,
                                listen: false)
                            .toggleFavorite(product.id!);
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 22.sp,
                        color: Colors.pink,
                      ))),
            ],
          )),
    );
  }
}
