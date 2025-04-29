import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class IcomeScreen extends StatelessWidget {
  const IcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              IncomeGraph(),
              IncomeButtonAdd(),
              IncomeList(),
            ],
          ),
        ),
      ),
    );
  }
}
