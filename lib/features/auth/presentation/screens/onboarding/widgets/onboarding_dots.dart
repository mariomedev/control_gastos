import 'package:flutter/widgets.dart';

import '../../../../../../core/core.dart';


class Dots extends StatelessWidget {
  const Dots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: ScreenHelper.responsiveWidth(context, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(),
          _Dot(),
          _Dot(),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: ScreenHelper.paddingSymmetric(horizontal: 5),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: Color(0xFF426AF9),
        shape: BoxShape.circle,
      ),
    );
  }
}
