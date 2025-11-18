import 'package:flutter/material.dart';

class CategoryColorSuggestions extends StatelessWidget {
  const CategoryColorSuggestions({
    super.key,
    required this.colorOptions,
    required this.selectedColor,
    required this.onColorSelected,
  });

  final List<String> colorOptions;
  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  @override
  Widget build(BuildContext context) {
    final normalizedSelected = _normalizeColor(selectedColor);
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colorOptions
          .map(
            (color) => GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _hexToColor(color),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: normalizedSelected == color
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  String _normalizeColor(String value) {
    final sanitized = value.startsWith('#') ? value : '#$value';
    return sanitized.toUpperCase();
  }

  Color _hexToColor(String value) {
    final sanitized = value.replaceFirst('#', '');
    if (sanitized.length == 6) {
      return Color(int.parse('0xFF$sanitized'));
    }
    if (sanitized.length == 8) {
      return Color(int.parse('0x$sanitized'));
    }
    return Colors.grey;
  }
}
