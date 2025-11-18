import '../../domain/domain.dart';

class CategoryMapper {
  const CategoryMapper._();

  static CategoryEntity fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      type: CategoryTypeX.fromString(map['type']?.toString() ?? 'expense'),
      icon: map['icon']?.toString() ?? '📁',
      color: map['color']?.toString() ?? '#A29BFE',
      isDefault: map['is_default'] == true,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }

  static Map<String, dynamic> toMap(CategoryEntity entity) {
    return {
      'id': entity.id,
      'user_id': entity.userId,
      'name': entity.name,
      'type': entity.type.value,
      'icon': entity.icon,
      'color': entity.color,
      'is_default': entity.isDefault,
      'created_at': entity.createdAt?.toIso8601String(),
    };
  }
}
