import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/cart_view/cart_product_widget.dart';
import '../../widgets/home_view/custom_button.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              _createProductsSection(),
              Expanded(
                child: Column(
                  children: [
                    _createCouponSection(),
                    SizedBox(
                      height: 2.h,
                    ),
                    _createPaymentInfo(),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: themeGreen,
                            borderRadius: BorderRadius.circular(22)),
                        child: Center(
                          child: FutureBuilder<double>(
                            future: cartViewModel.getCartTotalPrice(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                double totalPrice = snapshot.data ?? 0;

                                return totalPrice == 0
                                    ? Container()
                                    : Text(
                                        "Checkout for \$$totalPrice",
                                        style: TextStyle(
                                            color: themeWhite, fontSize: 14.sp),
                                      );
                              }
                            },
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        _createCustomAppBar(context),
      ])),
    );
  }

  Wrap _createPaymentInfo() {
    return Wrap(
      runSpacing: 12,
      children: [
        FutureBuilder(
            future: context.watch<CartViewModel>().getCartSubTotalPrice(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return TwoTextRowWidget(
                  label: "Subtotal",
                  value: "\$${snapshot.data}",
                );
              }
            }),
        const TwoTextRowWidget(
          label: "Delivery Fee",
          value: "\$13.00",
        ),
        const TwoTextRowWidget(
          label: "Discount",
          value: "\$5%",
        )
      ],
    );
  }

  Container _createCouponSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 6.5.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: themeGrey),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ADJ3AK",
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                "Promocode Applied",
                style: TextStyle(
                    color: themeGreen,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.check_circle,
                color: themeGreen,
              )
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _createProductsSection() {
    return SizedBox(
        height: 62.h,
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Consumer<CartViewModel>(
            builder: (context, cartViewModel, child) {
              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => CartProductWidget(
                        product: cartViewModel.products[index],
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cartViewModel.products.length);
            },
          ),
        ));
  }

  Padding _createCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 0.7),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CustomButton(
            icon: Icons.arrow_back_ios_new,
            function: () {
              Provider.of<CartViewModel>(context, listen: false).getItemCount();
              Navigator.pop(context);
            }),
        Text(
          "My Cart",
          style: TextStyle(
              color: themeBlack, fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
        CustomButton(
            icon: Icons.more_horiz,
            function: () {
              Navigator.pop(context);
            })
      ]),
    );
  }
}

class TwoTextRowWidget extends StatelessWidget {
  const TwoTextRowWidget({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
