import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_respone_model.dart';
import 'package:ecommerce_app/screens/product_detail_view/product_detail_view.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<ProductDetailViewModel>(context, listen: false)
            .setProduct(product);
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const ProductDetailView()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                image: product.images != null &&
                        product.images!.isNotEmpty &&
                        product.images![0].url != null
                    ? DecorationImage(
                        fit: BoxFit.contain,
                        image:
                            CachedNetworkImageProvider(product.images![0].url!))
                    : const DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/images/noImagePlaceholder.png')),
                borderRadius: BorderRadius.circular(30),
                color: themeGrey,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${product.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: themeTextGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 12.sp,
                        ),
                        Text(
                          "${product.rating}",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: themeBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "\$${product.price!.toInt()}",
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: themeBlack,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
