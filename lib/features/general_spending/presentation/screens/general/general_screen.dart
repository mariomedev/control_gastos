import 'package:flutter/material.dart';

import '../screens.dart';
import 'widgets/general_tap.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('General'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: GeneralTapBar(),
          ),
        ),
        body: TabBarView(
          children: [
            SpentScreen(),
            IcomeScreen(),
            RecordScreen()
          ],
        ),
      ),
    );
  }
}
