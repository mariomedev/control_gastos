import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';

class SpentButtonAdd extends StatelessWidget {
  const SpentButtonAdd({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomBottonTextShare(
      title: 'Agregar Gasto',
      onPressed: onPressed,
    );
  }
}
