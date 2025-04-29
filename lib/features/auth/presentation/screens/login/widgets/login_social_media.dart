import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/core.dart';

class LoginSocialMedia extends StatelessWidget {
  const LoginSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      child: SizedBox(
        height: ScreenHelper.responsiveHeight(context, 0.15),
        width: ScreenHelper.responsiveWidth(context, 0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TextImages.loginFooterText1,
              style: TextStyle(),
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/svg/icons/auth/apple.svg',
                    height: 36,
                    width: 36,
                  ),
                  SvgPicture.asset(
                    'assets/svg/icons/auth/facebook.svg',
                    height: 36,
                    width: 36,
                  ),
                  SvgPicture.asset(
                    'assets/svg/icons/auth/google.svg',
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
                Text(TextImages.loginFooterText2),
                TextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  child: Text(
                    TextImages.loginFooterText3,
                    style: TextStyle(fontSize: 18, color: Color(0xff426AF9)),
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
