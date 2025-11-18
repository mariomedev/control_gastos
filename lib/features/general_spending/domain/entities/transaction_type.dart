enum TransactionType {
  income('income'),
  expense('expense');

  const TransactionType(this.value);

  final String value;

  bool get isIncome => this == TransactionType.income;
  bool get isExpense => this == TransactionType.expense;

  static TransactionType fromValue(String? value) {
    if (value == null) return TransactionType.expense;
    return TransactionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => TransactionType.expense,
    );
  }
}
