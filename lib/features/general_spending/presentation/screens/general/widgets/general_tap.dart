import 'package:flutter/material.dart';

import 'general_tap_item.dart';

class GeneralTapBar extends StatelessWidget {
  const GeneralTapBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        height: 34,
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xff3366FF),
          ),
          unselectedLabelStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.white),
          tabs: [
            GeneralTapItem(title: 'Gastos'),
            GeneralTapItem(title: 'Ingresos'),
            GeneralTapItem(title: 'Historial'),
          ],
        ),
      ),
    );
  }
}
