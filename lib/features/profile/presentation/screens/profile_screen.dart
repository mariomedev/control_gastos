import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../profile_feature.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar tema al abrir la pantalla
    GetIt.instance<ThemeBloc>().add(const ThemeLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appBarProfile,
        ),
        centerTitle: true,
      ),
      body: const Column(
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
