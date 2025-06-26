import 'package:control_gastos/core/constants/constants.dart';
import 'package:control_gastos/features/auth/presentation/screens/onboarding/widgets/onboarding_page_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/providers.dart';

class OnboardingPageView extends ConsumerStatefulWidget {
  const OnboardingPageView({super.key});

  @override
  PageViewCustomState createState() => PageViewCustomState();
}

class PageViewCustomState extends ConsumerState<OnboardingPageView> {
  @override
  void initState() {
    final pageControllerState = ref.read(onboardingControllerProvider);
    final pageIndexController = ref.read(onboardingIndexProvider.notifier);
    pageControllerState!.addListener(
      () {
        pageIndexController.update(
          (state) => pageControllerState.page!.round(),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: ref.read(onboardingControllerProvider),
      children: [
        OnboardingPageItem(
          image: AppAssets.onboardingImage1,
          title: AppStrings.onboardTitle1,
          description: AppStrings.onboardSubTitle1,
        ),
        OnboardingPageItem(
          image: AppAssets.onboardingImage2,
          title: AppStrings.onboardTitle2,
          description: AppStrings.onboardSubTitle1,
        ),
        OnboardingPageItem(
          image: AppAssets.onboardingImage3,
          title: AppStrings.onboardTitle3,
          description: AppStrings.onboardSubTitle1,
        ),
      ],
    );
  }
}
