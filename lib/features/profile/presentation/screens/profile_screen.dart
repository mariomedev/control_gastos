import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.appBarProfile,
        ),
        centerTitle: true,
      ),
      body: Column(
        spacing: AppDimensions.kSpacing20,
        children: [
          ProfileInfoUser(),
          ProfileCardGoal(),
          ProfileSettings(),
          Spacer(),
          ProfileClose(),
        ],
      ),
    );
  }
}
