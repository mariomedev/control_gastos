import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '09/12/2022',
              style: TextStyle(fontSize: 16),
            ),
            Card(
              borderOnForeground: true,
              child: Container(
                color: Colors.white,
                height: 100,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}
