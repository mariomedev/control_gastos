import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/core.dart';
import '../../../bloc/bloc.dart';

class Dots extends StatelessWidget {
  const Dots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: ScreenHelper.responsiveWidth(context, 1),
      child: const Row(
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

class _Dot extends StatelessWidget {
  final int index;
  const _Dot({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      bloc: GetIt.instance<OnboardingBloc>(),
      builder: (context, state) {
        final colors = Theme.of(context).colorScheme;

        return Container(
          margin: ScreenHelper.paddingSymmetric(horizontal: 5),
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: (state.currentIndex == index) ? colors.primary : Colors.grey,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
