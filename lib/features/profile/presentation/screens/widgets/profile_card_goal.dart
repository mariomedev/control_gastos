import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class ProfileCardGoal extends StatelessWidget {
  const ProfileCardGoal({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Column(
      spacing: AppDimensions.kSpacing10,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.kPadding20,
            ),
            child: Text(
              'Metas del Mes',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.kMargin20,
          ),
          padding: EdgeInsets.all(
            AppDimensions.kPadding10,
          ),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(
              AppDimensions.kBorderRadius8,
            ),
          ),
          child: Column(
            spacing: AppDimensions.kSpacing10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.directions_run,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: LinearProgressIndicator(
                      value: 0.3,
                    ),
                  ),
                  Icon(
                    Icons.star,
                  ),
                ],
              ),
              Text(
                'Eres Un Campeón Todo lo puedes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
