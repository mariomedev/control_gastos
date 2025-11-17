import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/shared.dart';
import '../../../bloc/bloc.dart';

class OnboardingButton extends StatelessWidget {
  static PageController? _pageController;

  static void setPageController(PageController controller) {
    _pageController = controller;
  }

  const OnboardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      bloc: GetIt.instance<OnboardingBloc>(),
      builder: (context, state) {
        final isLastPage = state.currentIndex == 2;

        return CustomButtonShare(
          title: isLastPage ? 'Empezar' : 'Siguiente',
          onPressed: () {
            if (!isLastPage && _pageController != null) {
              _pageController!.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else if (isLastPage) {
              GetIt.instance<OnboardingBloc>().add(const CompleteOnboarding());
              context.go('/login');
            }
          },
        );
      },
    );
  }
}
