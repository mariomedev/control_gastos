import 'transaction_account_entity.dart';
import 'transaction_category_entity.dart';
import 'transaction_type.dart';

class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    this.categoryId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.account,
    this.category,
  });

  final String id;
  final String userId;
  final String accountId;
  final String? categoryId;
  final String title;
  final String? description;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TransactionAccountEntity? account;
  final TransactionCategoryEntity? category;

  bool get isExpense => type == TransactionType.expense;
  bool get isIncome => type == TransactionType.income;

  TransactionEntity copyWith({
    String? id,
    String? userId,
    String? accountId,
    String? categoryId,
    String? title,
    String? description,
    double? amount,
    TransactionType? type,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
    TransactionAccountEntity? account,
    TransactionCategoryEntity? category,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      account: account ?? this.account,
      category: category ?? this.category,
    );
  }
}
