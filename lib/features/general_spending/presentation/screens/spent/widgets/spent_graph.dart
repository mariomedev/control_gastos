import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../shared/widgets.dart';

class SpentGraph extends StatelessWidget {
  const SpentGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenHelper.responsiveHeight(context, 0.35),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Esta semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomButtonFilter(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
