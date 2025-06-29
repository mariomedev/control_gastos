import 'package:control_gastos/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileInfoUser extends StatelessWidget {
  const ProfileInfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    final img =
        'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg';
    final size = MediaQuery.of(context).size;
    return Column(
      spacing: AppDimensions.kSpacing10,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(img),
          maxRadius: size.width * 0.1,
        ),
        Text(
          'Mario Steven Melo Mendoza',
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}
