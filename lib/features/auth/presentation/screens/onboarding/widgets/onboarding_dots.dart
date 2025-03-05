import 'package:control_gastos/features/auth/presentation/provider/onboarding_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          _Dot(index: 0),
          _Dot(index: 1),
          _Dot(index: 2),
        ],
      ),
    );
  }
}

class _Dot extends ConsumerWidget {
  final int index;
  const _Dot({
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final indexProvider = ref.watch(onboardingIndexProvider);

    return Container(
      margin: ScreenHelper.paddingSymmetric(horizontal: 5),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: (indexProvider == index) ?  Color(0xFF426AF9) : Color(0xFFC4C4C4),
        shape: BoxShape.circle,
      ),
    );
  }
}
