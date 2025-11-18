class CreateAccountInput {
  final String userId;
  final String name;
  final String type;
  final double balance;
  final String currency;
  final String icon;
  final String color;
  final bool isActive;

  const CreateAccountInput({
    required this.userId,
    required this.name,
    required this.type,
    this.balance = 0,
    this.currency = 'USD',
    this.icon = '💵',
    this.color = '#00B894',
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'type': type,
      'balance': balance,
      'currency': currency,
      'icon': icon,
      'color': color,
      'is_active': isActive,
    };
  }
}
