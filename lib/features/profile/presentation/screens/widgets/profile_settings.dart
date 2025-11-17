import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../profile_feature.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: GetIt.instance<ThemeBloc>(),
      builder: (context, themeState) {
        return Column(
          spacing: AppDimensions.kSpacing10,
          children: [
            const _ProfileCard(
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
                    builder: (context) => const _NewColorTheme(),
                  );
                }),
            _ProfileCard(
              title: themeState.isDarkMode ? 'Modo Light' : 'Modo Dark',
              onTap: () => GetIt.instance<ThemeBloc>().add(
                ThemeDarkModeChanged(!themeState.isDarkMode),
              ),
            ),
            const _ProfileCard(
              title: 'Ayuda y Soporte',
            ),
          ],
        );
      },
    );
  }
}

class _NewColorTheme extends StatelessWidget {
  const _NewColorTheme();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: GetIt.instance<ThemeBloc>(),
      builder: (context, themeState) {
        return SizedBox(
          width: double.infinity,
          child: BlockPicker(
            pickerColor: themeState.colorScheme,
            onColorChanged: (color) => GetIt.instance<ThemeBloc>().add(
              ThemeColorChanged(color),
            ),
          ),
        );
      },
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
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.kMargin20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.kBorderRadius6),
          border: Border.all(
            color: colors.primary,
          ),
          color: isDark ? colors.onPrimaryContainer : Colors.white,
          boxShadow: [
            const BoxShadow(
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
