class TransactionAccountEntity {
  const TransactionAccountEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.type,
  });

  final String id;
  final String name;
  final String icon;
  final String color;
  final String? type;
}
