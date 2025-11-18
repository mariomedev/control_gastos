class AccountEntity {
  final String id;
  final String userId;
  final String name;
  final String type;
  final double balance;
  final String currency;
  final String icon;
  final String color;
  final bool isActive;
  final DateTime? createdAt;

  const AccountEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.balance,
    required this.currency,
    required this.icon,
    required this.color,
    required this.isActive,
    this.createdAt,
  });
}
