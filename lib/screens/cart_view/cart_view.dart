import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/home_view/custom_button.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
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
                          child: Text(
                        "Checkout for \$480.00",
                        style: TextStyle(color: themeWhite, fontSize: 14.sp),
                      )),
                    )
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
    return const Wrap(
      runSpacing: 12,
      children: [
        TwoTextRowWidget(
          label: "Subtotal",
          value: "\$800.00",
        ),
        TwoTextRowWidget(
          label: "Delivery Fee",
          value: "\$5.00",
        ),
        TwoTextRowWidget(
          label: "Discount",
          value: "\$40%",
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
          child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => const CartProductWidget(),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 10)),
    );
  }

  Padding _createCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 0.7),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CustomButton(
            icon: Icons.arrow_back_ios_new,
            function: () {
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

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
  });

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
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://www.arcelik.com.tr/media/resize/8905531600_OTH_20230516_091537.png/2000Wx2000H/image.webp")),
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
                      Text(
                        "Xbox Series X",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          onPressed: () {},
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
                        "\$570.00",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 9.w,
                              width: 9.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: themeTextGrey, width: 1.5),
                                  color: themeWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Icon(
                                Icons.remove,
                                color: themeBlack,
                              ),
                            ),
                            Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              height: 9.w,
                              width: 9.w,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: themeGreen, width: 1.5),
                                  color: themeWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Icon(
                                Icons.add,
                                color: themeGreen,
                              ),
                            )
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
}
