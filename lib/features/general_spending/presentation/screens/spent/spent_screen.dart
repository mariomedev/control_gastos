import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class SpentScreen extends StatelessWidget {
  const SpentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SpentGraph(),
                  SpentButtonAdd(),
                  SpentList(),
                ],
              ),            
            ),
          ],
        ),
      ),
    );
  }
}
