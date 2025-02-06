import 'package:control_gastos/core/constants/constants.dart';
import 'package:control_gastos/features/auth/presentation/screens/onboarding/widgets/onboarding_page_item.dart';
import 'package:flutter/widgets.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _PageViewCustomState();
}

class _PageViewCustomState extends State<OnboardingPageView> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    _pageController.addListener(() {
      //print(_pageController.page);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (value) {
        print(value);
      },
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
