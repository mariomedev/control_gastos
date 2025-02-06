import 'package:flutter/material.dart';

class OnboardingPageItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  
  const OnboardingPageItem({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Flexible(child: SizedBox()),
          Image.asset(image),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
