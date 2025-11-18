import 'package:flutter/material.dart';

class AccountsOverviewCard extends StatelessWidget {
  const AccountsOverviewCard({
    super.key,
    required this.totalBalance,
    required this.totalAccounts,
    this.onAddAccount,
  });

  final double totalBalance;
  final int totalAccounts;
  final VoidCallback? onAddAccount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            colors.primary.withValues(alpha: 0.12),
            colors.secondary.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: colors.primary.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tus cuentas',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Controla tus cuentas y agrega nuevas para llevar un mejor registro.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                style: IconButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                ),
                onPressed: onAddAccount,
                icon: const Icon(Icons.add),
                tooltip: 'Agregar cuenta',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _OverviewStat(
                label: 'Saldo total',
                value: _formatCurrency(totalBalance),
                colors: colors,
                theme: theme.textTheme,
              ),
              const SizedBox(width: 16),
              _OverviewStat(
                label: 'Cuentas activas',
                value: '$totalAccounts',
                colors: colors,
                theme: theme.textTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    final absValue = amount.abs().toStringAsFixed(2);
    final prefix = amount < 0 ? '-' : '';
    return '$prefix\$$absValue';
  }
}

class _OverviewStat extends StatelessWidget {
  const _OverviewStat({
    required this.label,
    required this.value,
    required this.colors,
    required this.theme,
  });

  final String label;
  final String value;
  final ColorScheme colors;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: colors.surfaceContainerHighest),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.labelMedium?.copyWith(color: colors.outline),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
