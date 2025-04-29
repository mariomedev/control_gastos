import 'package:flutter/material.dart';

import '../../core/core.dart';

class CustomButtonShare extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButtonShare({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.responsiveWidth(context, 0.1),
      ),
      child: SizedBox(
        width: ScreenHelper.responsiveWidth(context, 0.8),
        height: 55,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(0xFF3366FF)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
