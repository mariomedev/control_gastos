import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/core.dart';

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
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppDimensions.kSpacing10,
        children: [
          SvgPicture.asset(
            AppAssets.customButtonTextIcon,
            height: 26,
            width: 26,
            colorFilter: ColorFilter.mode(
              colors.primary,
              BlendMode.srcIn,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: colors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
