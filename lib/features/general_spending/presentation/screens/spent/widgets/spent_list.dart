import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class SpentList extends StatelessWidget {
  const SpentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const TransactionCategoryCardShared();
      },
    );
  }
}
