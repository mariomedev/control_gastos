import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import 'widgets/home_navigator_item.dart';

List<Widget> pages = [
  Icon(Icons.abc),
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
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(child: pages.elementAt(currentPage)),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeNavigatorItem(
                  onPressed: () => setState(() {
                    currentPage = 0;
                  }),
                  title: TextImages.homeNavigatorTitle1,
                  svg: TextImages.homeNavigatorIcon1,
                  isSeleted: currentPage == 0,
                ),
                HomeNavigatorItem(
                  onPressed: () => setState(() {
                    currentPage = 1;
                  }),
                  title: TextImages.homeNavigatorTitle2,
                  svg: TextImages.homeNavigatorIcon2,
                  isSeleted: currentPage == 1,
                ),
                HomeNavigatorItem(
                  onPressed: () => setState(() {
                    currentPage = 2;
                  }),
                  title: TextImages.homeNavigatorTitle3,
                  svg: TextImages.homeNavigatorIcon3,
                  isSeleted: currentPage == 2,
                ),
                HomeNavigatorItem(
                  onPressed: () => setState(() {
                    currentPage = 3;
                  }),
                  title: TextImages.homeNavigatorTitle4,
                  svg: TextImages.homeNavigatorIcon4,
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
