import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/cart_view_model.dart';
import 'package:ecommerce_app/view_models/product_detail_view_model.dart';
import 'package:ecommerce_app/widgets/home_view/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/product_respone_model.dart';
import '../../widgets/product_detail_view/detail_page_widget.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetailViewModel =
        Provider.of<ProductDetailViewModel>(context, listen: true);

    Product product = productDetailViewModel.product;

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeWhite,
        body: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              height: 85.h,
              child: ListView(
                children: [
                  _PhotosSection(product: product),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: themeWhite),
                    child: Column(
                      children: [
                        _createNameAndSaleSection(product),
                        const SizedBox(height: 10),
                        _createLikeAndReviewSection(product),
                        const SizedBox(height: 10),
                        _createDescription("${product.description}")
                      ],
                    ),
                  )
                ],
              ),
            ),
            _createPriceAndAddtoCart(product, context)
          ]),
          _createCustomAppBar(context),
        ]),
      ),
    );
  }

  Padding _createCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
              icon: Icons.arrow_back_ios_new,
              function: () async {
                if (!context.mounted) return;
                Navigator.of(context).pop();
                await context.read<CartViewModel>().getItemCount();
              }),
          Row(
            children: [
              CustomButton(
                  icon: Icons.favorite,
                  function: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                width: 15,
              ),
              CustomButton(
                  icon: Icons.share_outlined,
                  function: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ],
      ),
    );
  }

  Container _createPriceAndAddtoCart(Product product, BuildContext context) {
    return Container(
      color: themeWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    height: 60,
                    width: 200,
                    child: FutureBuilder<bool>(
                      future: Provider.of<CartViewModel>(context, listen: true)
                          .isProductInCart(product.id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          bool isInCart = snapshot.data ?? false;

                          if (isInCart) {
                            // Sepette varsa farklı bir widget göster
                            return Container(
                              decoration: BoxDecoration(
                                  color: themeGreen.withAlpha(70),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  "In Cart",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: themeGreen,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          } else {
                            return _createAddToCartButton(context, product.id!);
                          }
                        }
                      },
                    ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  OutlinedButton _createAddToCartButton(BuildContext context, int productId) {
    return OutlinedButton(
        onPressed: () async {
          await Provider.of<CartViewModel>(context, listen: false)
              .increaseItemQuantityById(productId);
          if (!context.mounted) return;
          await Provider.of<CartViewModel>(context, listen: false)
              .fetchProducts();
        },
        style: ButtonStyle(
            side: const WidgetStatePropertyAll(BorderSide.none),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            backgroundColor: const WidgetStatePropertyAll(themeGreen)),
        child: Text(
          "Add to Cart",
          style: TextStyle(
              fontSize: 12.sp, color: themeWhite, fontWeight: FontWeight.bold),
        ));
  }

  Text _createDescription(String description) {
    return Text(
      description,
      style: TextStyle(
          color: themeBlack, fontSize: 10.sp, fontWeight: FontWeight.w500),
    );
  }

  Row _createLikeAndReviewSection(Product product) {
    return Row(
      children: [
        DetailPageWidget(
          icon: Icons.star,
          label: "${product.rating}",
        ),
        const SizedBox(width: 10),
        const DetailPageWidget(
          icon: Icons.thumb_up,
          label: "97%",
        ),
        const SizedBox(width: 10),
        Text(
          "117 reviews",
          style: TextStyle(
              fontSize: 10.sp,
              color: themeTextGrey,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row _createNameAndSaleSection(Product product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "${product.name}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15.sp,
                color: themeBlack,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "% On Sale",
              style: TextStyle(color: themeWhite, fontSize: 9.sp),
            ),
          ),
        )
      ],
    );
  }
}

class _PhotosSection extends StatefulWidget {
  const _PhotosSection({
    required this.product,
  });

  final Product product;

  @override
  State<_PhotosSection> createState() => _PhotosSectionState();
}

class _PhotosSectionState extends State<_PhotosSection> {
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: themeGrey,
        height: 50.h,
        child: Column(
          children: [
            SizedBox(
              height: 48.h,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    activePage = value;
                  });
                },
                physics: const ClampingScrollPhysics(),
                itemCount: widget.product.images!.length,
                itemBuilder: (context, index) =>
                    PhotoWidget(url: widget.product.images![index].url ?? ""),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.images!.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 2.w,
                  width: 2.w,
                  decoration: BoxDecoration(
                      color: index == activePage ? themeGreen : themeLightGreen,
                      shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ));
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.url,
  });
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
    );
  }
}
