import 'package:ecommerce_app/screens/login_view.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/main_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _SliverAppBar(),
        const _AvatarAndNameSection(),
        SliverList(
          delegate: SliverChildListDelegate([
            _ProfileOptionWidget(
              title: "Orders",
              icon: Icons.shopping_basket_outlined,
              func: () {},
            ),
            _ProfileOptionWidget(
              title: "Payment Methods",
              icon: Icons.payment,
              func: () {},
            ),
            _ProfileOptionWidget(
              title: "Addresses",
              icon: Icons.location_on_outlined,
              func: () {},
            ),
            _ProfileOptionWidget(
              title: "Coupons",
              icon: Icons.discount_outlined,
              func: () {},
            ),
            _ProfileOptionWidget(
              title: "Favorites",
              icon: Icons.favorite_border,
              func: () {
                context.read<MainPageViewModel>().changeActivePage(2);
              },
            ),
            _ProfileOptionWidget(
              title: "Settings",
              icon: Icons.settings,
              func: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: AspectRatio(
                  aspectRatio: 8,
                  child: OutlinedButton(
                      style: ButtonStyle(
                          side: WidgetStatePropertyAll(BorderSide(
                              width: 3,
                              color: themeTextGrey.withOpacity(0.3)))),
                      onPressed: () async {
                        await context.read<UserService>().logout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ));
                      },
                      child: Text(
                        "Log out",
                        style: TextStyle(fontSize: 12.sp, color: themeTextGrey),
                      ))),
            )
          ]),
        ),
      ],
    );
  }
}

class _ProfileOptionWidget extends StatelessWidget {
  const _ProfileOptionWidget({
    required this.title,
    required this.icon,
    required this.func,
  });
  final String title;
  final IconData icon;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          InkWell(
            onTap: () => func(),
            child: AspectRatio(
              aspectRatio: 7,
              child: Container(
                color: themeWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icon,
                          size: 16.sp,
                        ),
                        const SizedBox(
                          width: defaultPadding / 2,
                        ),
                        Text(
                          title,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    const Icon(CupertinoIcons.forward),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _AvatarAndNameSection extends StatelessWidget {
  const _AvatarAndNameSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 20.h,
        color: themeGreen,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: themeWhite.withOpacity(0.8),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              context.read<UserService>().user!.name.toString(),
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: themeWhite),
            )
          ],
        ),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      floating: false,
      centerTitle: true,
      backgroundColor: themeGreen,
      expandedHeight: 10.h,
      title: const Text("My Account"),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_outlined,
              size: 18.sp,
            )),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
