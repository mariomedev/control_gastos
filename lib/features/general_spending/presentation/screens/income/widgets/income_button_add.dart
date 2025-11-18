import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';

class IncomeButtonAdd extends StatelessWidget {
  const IncomeButtonAdd({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomBottonTextShare(
      title: 'Agregar Ingreso',
      onPressed: onPressed,
    );
  }
}
