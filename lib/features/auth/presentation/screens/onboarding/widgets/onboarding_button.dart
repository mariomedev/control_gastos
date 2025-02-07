import 'package:control_gastos/core/utils/helpers/screen_helper.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key});

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
          child: Text(
            'Siguiente',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
           
          },
        ),
      ),
    );
  }}
