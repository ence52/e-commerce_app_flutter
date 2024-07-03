import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/home_view/item_card.dart';

class SeachView extends StatefulWidget {
  const SeachView({super.key});

  @override
  State<SeachView> createState() => _SeachViewState();
}

class _SeachViewState extends State<SeachView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: themeWhite,
        width: double.infinity,
        child: Column(
          children: [
            const _TitleText(),
            _SearchField(),
            SizedBox(
              height: 20,
            ),
            _Body()
          ],
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    super.key,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final searchViewModel = context.watch<SearchViewModel>();
    if (searchViewModel.products.isEmpty && !searchViewModel.isSearchFailed) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 70.sp,
              color: themeTextGrey,
            ),
            Text(
              "Type to search Products",
              style: TextStyle(fontSize: 18.sp, color: themeTextGrey),
            ),
          ],
        ),
      );
    } else if (searchViewModel.products.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 70.sp,
              color: themeTextGrey,
            ),
            Text(
              "Product not found ",
              style: TextStyle(fontSize: 18.sp, color: themeTextGrey),
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        child: Consumer<SearchViewModel>(
          builder: (context, searchViewModel, child) {
            return GridView.builder(
              physics: const ClampingScrollPhysics(),
              cacheExtent: 2000,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 4 / 5,
              ),
              itemCount: searchViewModel.products.length,
              itemBuilder: (context, index) {
                return ItemCard(product: searchViewModel.products[index]);
              },
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            );
          },
        ),
      );
    }
  }
}

class _SearchField extends StatelessWidget {
  _SearchField({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final searchViewModel =
        Provider.of<SearchViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      child: TextField(
        style: TextStyle(fontSize: 10.sp),
        onChanged: (value) async {
          if (value.isEmpty) {
            searchViewModel.removeProducts();
            searchViewModel.setSearchFailed(false);
          } else {
            await searchViewModel.fetchProductsBySearchText(value);
          }

          if (searchViewModel.products.isEmpty && value.isNotEmpty) {
            searchViewModel.setSearchFailed(true);
          }
        },
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
}

class _TitleText extends StatelessWidget {
  const _TitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding * 0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Search",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
