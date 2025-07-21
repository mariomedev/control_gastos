import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../provider/providers.dart';

class ProfileSettings extends ConsumerWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.read(themeProviderState.notifier);
    final themeState = ref.watch(themeProviderState);
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
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => _NewColorTheme(),
              );
            }),
        _ProfileCard(
          title: themeState.isDarkMode ? 'Modo Light' : 'Modo Dark',
          onTap: () => themeController.onChangeDarkMode(!themeState.isDarkMode),
        ),
        _ProfileCard(
          title: 'Ayuda y Soporte',
        ),
      ],
    );
  }
}

class _NewColorTheme extends ConsumerWidget {
  const _NewColorTheme();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.read(themeProviderState.notifier);
    final themeColorState = ref.watch(themeProviderState).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: BlockPicker(
        pickerColor: themeColorState,
        onColorChanged: (color) => themeController.onChangeTheme(color),
      ),
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
