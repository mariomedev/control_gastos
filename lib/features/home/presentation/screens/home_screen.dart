import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../general_spending/presentation/screens/screens.dart';
import 'widgets/home_navigator_item.dart';

List<Widget> pages = [
  GeneralScreen(),
  Icon(Icons.aspect_ratio),
  Icon(Icons.wallet),
  Icon(Icons.question_answer),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageViewController = PageController();
  int currentPage = 0;

  _changePage(int page) {
    //pageViewController.jumpToPage(page);
    pageViewController.animateToPage(
      page,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: PageView(
          controller: pageViewController,
          onPageChanged: (index) => setState(() {
            currentPage = index;
          }),
          children: pages,
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.kPadding30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeNavigatorItem(
                  onPressed: () => _changePage(0),
                  title: AppStrings.homeNavigatorTitle1,
                  svg: AppAssets.homeNavigatorIcon1,
                  isSeleted: currentPage == 0,
                ),
                HomeNavigatorItem(
                  onPressed: () => _changePage(1),
                  title: AppStrings.homeNavigatorTitle2,
                  svg: AppAssets.homeNavigatorIcon2,
                  isSeleted: currentPage == 1,
                ),
                HomeNavigatorItem(
                  onPressed: () => _changePage(2),
                  title: AppStrings.homeNavigatorTitle3,
                  svg: AppAssets.homeNavigatorIcon3,
                  isSeleted: currentPage == 2,
                ),
                HomeNavigatorItem(
                  onPressed: () => _changePage(3),
                  title: AppStrings.homeNavigatorTitle4,
                  svg: AppAssets.homeNavigatorIcon4,
                  isSeleted: currentPage == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
