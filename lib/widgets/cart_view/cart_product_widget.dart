import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/product_cart_model.dart';
import '../../utils/constants.dart';
import '../../view_models/cart_view_model.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    required this.product,
  });
  final ProductCartResponseModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      color: themeWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                  image: product.images != null &&
                          product.images!.isNotEmpty &&
                          product.images![0].url != null
                      ? DecorationImage(
                          fit: BoxFit.contain,
                          image: CachedNetworkImageProvider(
                              product.images![0].url!))
                      : const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/noImagePlaceholder.png')),
                  color: themeGrey,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          product.name!,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      IconButton(
                          splashColor: WidgetStateColor.transparent,
                          onPressed: () async {
                            var cartViewModel = Provider.of<CartViewModel>(
                                context,
                                listen: false);
                            await cartViewModel
                                .removeProductFromCartList(product.id!);
                            if (cartViewModel.products.isEmpty) {
                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                            }
                          },
                          icon: Icon(
                            Icons.close,
                            size: 15.sp,
                            color: themeTextGrey,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        "\$${product.price}",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _createDecreaseButton(context),
                            _createItemCounter(context),
                            _createIncreaseButton(context)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell _createIncreaseButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        var cartViewModel = Provider.of<CartViewModel>(context, listen: false);
        await cartViewModel.increaseItemQuantityById(product.id!);
      },
      child: Container(
        height: 9.w,
        width: 9.w,
        decoration: BoxDecoration(
            border: Border.all(color: themeGreen, width: 1.5),
            color: themeWhite,
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(
          Icons.add,
          color: themeGreen,
        ),
      ),
    );
  }

  InkWell _createDecreaseButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        var cartViewModel = Provider.of<CartViewModel>(context, listen: false);
        var currentQuantity = await cartViewModel.getItemQuantity(product.id!);

        if (currentQuantity > 1) {
          await cartViewModel.decreaseItemQuantityById(product.id!);
        } else {
          await cartViewModel.removeProductFromCartList(product.id!);
        }

        if (cartViewModel.products.isEmpty) {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        }
      },
      child: Container(
        height: 9.w,
        width: 9.w,
        decoration: BoxDecoration(
            border: Border.all(color: themeTextGrey, width: 1.5),
            color: themeWhite,
            borderRadius: BorderRadius.circular(15)),
        child: const Icon(
          Icons.remove,
          color: themeBlack,
        ),
      ),
    );
  }

  FutureBuilder<int> _createItemCounter(BuildContext context) {
    return FutureBuilder<int>(
        future: context.watch<CartViewModel>().getItemQuantity(product.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            int quantity = snapshot.data ?? 0;
            return Text(
              quantity.toString(),
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            );
          }
        });
  }
}
