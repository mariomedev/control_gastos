import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class ProfileClose extends StatelessWidget {
  const ProfileClose({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: AppDimensions.kSpacing10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.power,
              color: Colors.red,
            ),
            Text(
              'Cerrar sesión',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Text('Version 1.0'),
        SizedBox(),
      ],
    );
  }
}
