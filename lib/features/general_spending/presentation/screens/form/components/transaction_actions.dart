import 'package:flutter/material.dart';

class TransactionActions extends StatelessWidget {
  const TransactionActions({
    super.key,
    required this.isSubmitting,
    required this.isEdit,
    required this.onCancel,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final bool isEdit;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isSubmitting ? null : onCancel,
            child: const Text('Cancelar'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton(
            onPressed: isSubmitting ? null : onSubmit,
            child: isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(isEdit ? 'Guardar cambios' : 'Guardar'),
          ),
        ),
      ],
    );
  }
}
