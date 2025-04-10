import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeNavigatorItem extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final String svg;
  final bool isSeleted;
  const HomeNavigatorItem({
    super.key,
    this.onPressed,
    required this.title,
    required this.svg,
    required this.isSeleted,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        spacing: 6,
        children: [
          SvgPicture.asset(
            svg,
            height: 26,
            width: 26,
            colorFilter: ColorFilter.mode(
              isSeleted ? Color(0xff3366FF) : Color(0xff92929D),
              BlendMode.srcIn,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: isSeleted ? Color(0xff3366FF) : Color(0xff92929D),
            ),
          ),
        ],
      ),
    );
  }
}
