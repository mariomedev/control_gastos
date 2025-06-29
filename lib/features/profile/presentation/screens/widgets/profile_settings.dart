import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimensions.kSpacing10,
      children: [
        _ProfileCard(
          title: 'Moneda',
        ),
        _ProfileCard(
          title: 'Categorías',
          onTap: () => context.push('/categories'),
        ),
        _ProfileCard(
          title: 'Color de tema',
        ),
        _ProfileCard(
          title: 'Modo Oscuro',
        ),
        _ProfileCard(
          title: 'Ayuda y Soporte',
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const _ProfileCard({
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.kMargin20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.kBorderRadius6),
          border: Border.all(
            color: colors.primary,
          ),
          color: isDark ? colors.onPrimaryContainer : Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
              offset: Offset(5, 5),
            )
          ],
        ),
        child: ListTile(
          title: Text(title),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: colors.primary,
          ),
        ),
      ),
    );
  }
}
