import 'package:flutter/material.dart';

import 'package:control_gastos/core/core.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
    );
  }
}
