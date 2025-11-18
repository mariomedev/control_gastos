import '../entities/transaction_type.dart';

class CreateTransactionInput {
  CreateTransactionInput({
    required this.userId,
    required this.accountId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.description,
    this.categoryId,
  });

  final String userId;
  final String accountId;
  final String? categoryId;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String? description;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'account_id': accountId,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.value,
    }..removeWhere((key, value) => value == null || value == '');
  }
}
