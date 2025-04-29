import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/core.dart';

class CustomBottonTextShare extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const CustomBottonTextShare({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          SvgPicture.asset(
            TextImages.customButtonTextIcon,
            height: 26,
            width: 26,
            colorFilter: ColorFilter.mode(
              Color(0xff3366FF),
              BlendMode.srcIn,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF3366FF),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
