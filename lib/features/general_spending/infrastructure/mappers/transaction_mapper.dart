import '../../domain/domain.dart';

class TransactionMapper {
  static TransactionEntity fromMap(Map<String, dynamic> map) {
    final accountMap = map['accounts'];
    final categoryMap = map['categories'];

    return TransactionEntity(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      accountId: map['account_id']?.toString() ?? '',
      categoryId: map['category_id']?.toString(),
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString(),
      amount: _parseDouble(map['amount']),
      type: TransactionType.fromValue(map['type']?.toString()),
      date: _parseDate(map['date']),
      createdAt: _parseDate(map['created_at']),
      updatedAt: _parseDate(map['updated_at']),
      account: accountMap == null
          ? null
          : TransactionAccountEntity(
              id: accountMap['id']?.toString() ?? '',
              name: accountMap['name']?.toString() ?? '',
              icon: accountMap['icon']?.toString() ?? '🏦',
              color: accountMap['color']?.toString() ?? '#FFFFFF',
              type: accountMap['type']?.toString(),
            ),
      category: categoryMap == null
          ? null
          : TransactionCategoryEntity(
              id: categoryMap['id']?.toString() ?? '',
              name: categoryMap['name']?.toString() ?? '',
              icon: categoryMap['icon']?.toString() ?? '🏷️',
              color: categoryMap['color']?.toString() ?? '#FFFFFF',
            ),
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    if (value is DateTime) return value;

    return DateTime.tryParse(value.toString()) ?? DateTime.now();
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}
