import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../domain/domain.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    super.key,
    required this.category,
    this.onEdit,
    this.onDelete,
  });

  final CategoryEntity category;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accentColor = _colorFromHex(category.color, colors.primary);
    final subtitle = category.isDefault
        ? 'Categoría predeterminada'
        : 'Categoría ${category.type.label.toLowerCase()}';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.kPadding20,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: AppDimensions.kMargin10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: accentColor.withAlpha(31),
            child: Text(category.icon, style: const TextStyle(fontSize: 20)),
          ),
          title: Text(category.name),
          subtitle: Text(subtitle),
          trailing: _buildActions(context),
        ),
      ),
    );
  }

  Widget? _buildActions(BuildContext context) {
    final actions = [];

    if (onEdit != null) {
      actions.add(_CategoryAction.edit);
    }

    if (onDelete != null) {
      actions.add(_CategoryAction.delete);
    }

    if (actions.isEmpty) {
      return null;
    }

    return PopupMenuButton<_CategoryAction>(
      onSelected: (action) {
        switch (action) {
          case _CategoryAction.edit:
            onEdit?.call();
            break;
          case _CategoryAction.delete:
            if (!category.isDefault) {
              onDelete?.call();
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          if (onEdit != null)
            const PopupMenuItem<_CategoryAction>(
              value: _CategoryAction.edit,
              child: Text('Editar'),
            ),
          if (onDelete != null)
            PopupMenuItem<_CategoryAction>(
              value: _CategoryAction.delete,
              enabled: !category.isDefault,
              child: Text(
                category.isDefault ? 'No se puede eliminar' : 'Eliminar',
              ),
            ),
        ];
      },
    );
  }

  Color _colorFromHex(String color, Color fallback) {
    final sanitized = color.replaceFirst('#', '');
    if (sanitized.length == 3) {
      final expanded = sanitized.split('').map((char) => '$char$char').join();
      return Color(int.parse('0xFF$expanded'));
    }

    if (sanitized.length == 6) {
      return Color(int.parse('0xFF$sanitized'));
    }

    if (sanitized.length == 8) {
      return Color(int.parse('0x$sanitized'));
    }

    return fallback;
  }
}

enum _CategoryAction { edit, delete }
