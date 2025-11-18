import 'category_entity.dart';

class CreateCategoryInput {
  CreateCategoryInput({
    required this.userId,
    required this.name,
    required this.type,
    this.icon = '📁',
    this.color = '#A29BFE',
  });

  final String userId;
  final String name;
  final CategoryType type;
  final String icon;
  final String color;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'type': type.value,
      'icon': icon,
      'color': color,
      'is_default': false,
    };
  }
}
