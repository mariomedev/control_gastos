import '../entities/transaction_type.dart';

class UpdateTransactionInput {
  UpdateTransactionInput({
    required this.transactionId,
    required this.accountId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.description,
    this.categoryId,
  });

  final String transactionId;
  final String accountId;
  final String? categoryId;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String? description;

  Map<String, dynamic> toMap() {
    return {
      'account_id': accountId,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
    }..removeWhere((key, value) => value == null || value == '');
  }
}
