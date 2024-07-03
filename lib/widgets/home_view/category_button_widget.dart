import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoryButtonWidget extends StatefulWidget {
  const CategoryButtonWidget({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  State<CategoryButtonWidget> createState() => _CategoryButtonWidgetState();
}

class _CategoryButtonWidgetState extends State<CategoryButtonWidget> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: true);

    isActive = homeViewModel.activeCategory == widget.category.id;
    return Row(
      children: [
        OutlinedButton(
            onPressed: () async {
              homeViewModel.changeActiveCategory(widget.category.id);
              widget.category.id == -1
                  ? await Provider.of<HomeViewModel>(context, listen: false)
                      .fetchProducts()
                  : await Provider.of<HomeViewModel>(context, listen: false)
                      .fetchProductsByCategory(widget.category.id);
            },
            style: isActive
                ? ButtonStyle(
                    side: const WidgetStatePropertyAll(BorderSide.none),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    backgroundColor: const WidgetStatePropertyAll(themeGreen))
                : ButtonStyle(
                    side: const WidgetStatePropertyAll(
                        BorderSide(width: 2, color: themeTextGrey)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
                    backgroundColor: const WidgetStatePropertyAll(themeWhite)),
            child: Text(
              widget.category.name,
              style: TextStyle(
                  fontSize: 12.sp, color: isActive ? themeWhite : themeBlack),
            )),
      ],
    );
  }
}
