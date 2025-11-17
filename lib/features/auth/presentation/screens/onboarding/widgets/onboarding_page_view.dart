import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:control_gastos/core/constants/constants.dart';
import 'package:control_gastos/features/auth/presentation/screens/onboarding/widgets/onboarding_page_item.dart';
import 'onboarding_button.dart';
import '../../../bloc/bloc.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  PageViewCustomState createState() => PageViewCustomState();
}

class PageViewCustomState extends State<OnboardingPageView> {
  late PageController _pageController;
  int _lastIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Pasar el PageController al botón
    OnboardingButton.setPageController(_pageController);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      bloc: GetIt.instance<OnboardingBloc>(),
      listenWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      listener: (context, state) {
        if (state.currentIndex != _lastIndex &&
            _pageController.page!.round() != state.currentIndex) {
          _pageController.animateToPage(
            state.currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
        _lastIndex = state.currentIndex;
      },
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _lastIndex = index;
          GetIt.instance<OnboardingBloc>().add(OnboardingPageChanged(index));
        },
        children: [
          const OnboardingPageItem(
            image: AppAssets.onboardingImage1,
            title: AppStrings.onboardTitle1,
            description: AppStrings.onboardSubTitle1,
          ),
          const OnboardingPageItem(
            image: AppAssets.onboardingImage2,
            title: AppStrings.onboardTitle2,
            description: AppStrings.onboardSubTitle2,
          ),
          const OnboardingPageItem(
            image: AppAssets.onboardingImage3,
            title: AppStrings.onboardTitle3,
            description: AppStrings.onboardSubTitle3,
          ),
        ],
      ),
    );
  }
}
