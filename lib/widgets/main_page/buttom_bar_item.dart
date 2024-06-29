import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view_models/main_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ButtomBarItem extends StatefulWidget {
  const ButtomBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.pageId,
  });
  final IconData icon;
  final int pageId;
  final String label;

  @override
  State<ButtomBarItem> createState() => _ButtomBarItemState();
}

class _ButtomBarItemState extends State<ButtomBarItem> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final mainPageViewModel =
        Provider.of<MainPageViewModel>(context, listen: true);

    isActive = mainPageViewModel.activePageId == widget.pageId;
    return InkWell(
      onTap: () {
        mainPageViewModel.changeActivePage(widget.pageId);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            widget.icon,
            size: 18.sp,
            color: isActive ? themeGreen : themeBlack,
          ),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 9.sp,
              color: isActive ? themeGreen : themeBlack,
            ),
          )
        ],
      ),
    );
  }
}
