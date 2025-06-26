import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/core.dart';

class LoginSocialMedia extends StatelessWidget {
  const LoginSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 16,
        color: isDark ? Colors.white : Colors.black,
      ),
      child: SizedBox(
        height: ScreenHelper.responsiveHeight(context, 0.15),
        width: ScreenHelper.responsiveWidth(context, 0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.loginFooterText1,
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    AppAssets.appleIcon,
                    height: 36,
                    width: 36,
                    colorFilter: ColorFilter.mode(
                        colors.brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn),
                  ),
                  SvgPicture.asset(
                    AppAssets.facebookIcon,
                    height: 36,
                    width: 36,
                  ),
                  SvgPicture.asset(
                    AppAssets.googleIcon,
                    height: 36,
                    width: 36,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Text(AppStrings.loginFooterText2),
                TextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  child: Text(
                    AppStrings.loginFooterText3,
                    style: TextStyle(
                      fontSize: 18,
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
