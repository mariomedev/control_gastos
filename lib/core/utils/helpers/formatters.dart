import 'package:intl/intl.dart';

String formatCurrency(double value, {bool includeSign = true}) {
  final formatter = NumberFormat.currency(
    locale: 'es',
    symbol: r'$',
    decimalDigits: 2,
  );
  final formatted = formatter.format(value.abs());
  if (!includeSign) return formatted;
  final sign = value >= 0 ? '+' : '-';
  return '$sign$formatted';
}

String formatShortDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(date.year, date.month, date.day);

  if (target == today) {
    return 'Hoy';
  }

  if (target == today.subtract(const Duration(days: 1))) {
    return 'Ayer';
  }

  return DateFormat('dd MMM', 'es').format(date);
}

String formatFullDate(DateTime date) {
  return DateFormat('dd/MM/yyyy', 'es').format(date);
}
