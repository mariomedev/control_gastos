import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.account, this.onDelete});

  final AccountEntity account;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final accentColor = _colorFromHex(account.color);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.surfaceContainerHighest),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                account.icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  account.type,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.outline,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatCurrency(account.balance, account.currency),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (onDelete != null) const SizedBox(width: 4),
                  if (onDelete != null)
                    PopupMenuButton<_AccountCardMenuAction>(
                      tooltip: 'Opciones de cuenta',
                      onSelected: (value) {
                        if (value == _AccountCardMenuAction.delete) {
                          onDelete?.call();
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem<_AccountCardMenuAction>(
                          value: _AccountCardMenuAction.delete,
                          child: Text('Eliminar cuenta'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert_outlined),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: account.isActive
                      ? Colors.green.withValues(alpha: 0.15)
                      : Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  account.isActive ? 'Activa' : 'Inactiva',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: account.isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _colorFromHex(String color) {
    final sanitized = color.replaceFirst('#', '');
    final hexValue = switch (sanitized.length) {
      6 => 'ff$sanitized',
      8 => sanitized,
      _ => sanitized.padLeft(8, 'f'),
    };
    return Color(int.parse(hexValue, radix: 16));
  }

  String _formatCurrency(double amount, String currency) {
    final formatted = amount.toStringAsFixed(2);
    return '$currency $formatted';
  }
}

enum _AccountCardMenuAction { delete }
