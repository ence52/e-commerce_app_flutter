import 'package:ecommerce_app/utils/constants.dart';
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
                  _createPhotosSection(product),
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
            _createPriceAndAddtoCart(product)
          ]),
          Padding(
            padding: const EdgeInsets.all(defaultPadding * 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    icon: Icons.arrow_back_ios_new,
                    function: () {
                      Navigator.pop(context);
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
          ),
        ]),
      ),
    );
  }

  Container _createPhotosSection(Product product) {
    return Container(
        color: themeGrey,
        height: 50.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.images!.length,
            itemBuilder: (c, i) =>
                PhotoWidget(url: product.images![i].url ?? "")));
  }

  Container _createPriceAndAddtoCart(Product product) {
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
                  child: OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          side: const WidgetStatePropertyAll(BorderSide.none),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                          backgroundColor:
                              const WidgetStatePropertyAll(themeGreen)),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: themeWhite,
                            fontWeight: FontWeight.bold),
                      )),
                ),
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

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.url,
  });
  final String url;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.contain,
    );
  }
}
