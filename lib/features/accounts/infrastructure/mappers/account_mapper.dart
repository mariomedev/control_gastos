import '../../domain/domain.dart';

class AccountMapper {
  const AccountMapper._();

  static AccountEntity fromMap(Map<String, dynamic> map) {
    return AccountEntity(
      id: map['id'].toString(),
      userId: map['user_id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      type: map['type']?.toString() ?? '',
      balance: (map['balance'] is num)
          ? (map['balance'] as num).toDouble()
          : double.tryParse(map['balance']?.toString() ?? '0') ?? 0,
      currency: map['currency']?.toString() ?? 'USD',
      icon: map['icon']?.toString() ?? '💵',
      color: map['color']?.toString() ?? '#00B894',
      isActive: map['is_active'] is bool
          ? map['is_active'] as bool
          : map['is_active'].toString().toLowerCase() == 'true',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }

  static Map<String, dynamic> toMap(AccountEntity entity) {
    return {
      'id': entity.id,
      'user_id': entity.userId,
      'name': entity.name,
      'type': entity.type,
      'balance': entity.balance,
      'currency': entity.currency,
      'icon': entity.icon,
      'color': entity.color,
      'is_active': entity.isActive,
      'created_at': entity.createdAt?.toIso8601String(),
    };
  }
}
