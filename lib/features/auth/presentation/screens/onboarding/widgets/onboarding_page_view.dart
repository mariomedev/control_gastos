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
    final pageController = ref.read(onboardingControllerProvider);
    super.initState();
    pageController!.addListener(
      () {
        ref
            .read(onboardingIndexProvider.notifier)
            .update((state) => pageController.page!.round());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: ref.read(onboardingControllerProvider),
      children: [
        OnboardingPageItem(
          image: TextImages.onboardingImage1,
          title: TextImages.onboardTitle1,
          description: TextImages.onboardSubTitle1,
        ),
        OnboardingPageItem(
          image: TextImages.onboardingImage2,
          title: TextImages.onboardTitle2,
          description: TextImages.onboardSubTitle1,
        ),
        OnboardingPageItem(
          image: TextImages.onboardingImage3,
          title: TextImages.onboardTitle3,
          description: TextImages.onboardSubTitle1,
        ),
      ],
    );
  }
}
