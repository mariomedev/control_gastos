import 'package:control_gastos/core/constants/storage/app_dimensions.dart';
import 'package:flutter/material.dart';

import 'general_tap_item.dart';

class GeneralTapBar extends StatelessWidget {
  const GeneralTapBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimensions.kBorderRadius8),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppDimensions.kMargin30),
            decoration: BoxDecoration(
                color: colors.onPrimaryContainer,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.kBorderRadius8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(3, 3),
                  )
                ]),
            height: 34,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.kBorderRadius8),
                color: colors.primary,
              ),
              unselectedLabelStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              labelStyle: TextStyle(
                color: isDark ? Colors.black : Colors.white,
              ),
              tabs: [
                GeneralTapItem(title: 'Gastos'),
                GeneralTapItem(title: 'Ingresos'),
                GeneralTapItem(title: 'Historial'),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.kMargin10)
        ],
      ),
    );
  }
}
