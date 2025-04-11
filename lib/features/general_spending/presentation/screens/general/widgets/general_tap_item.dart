import 'package:flutter/material.dart';

class GeneralTapItem extends StatelessWidget {
  final String title;
  const GeneralTapItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
