import 'package:equatable/equatable.dart';

enum CategoryType { income, expense }

extension CategoryTypeX on CategoryType {
  String get value => this == CategoryType.income ? 'income' : 'expense';

  String get label => this == CategoryType.income ? 'Ingreso' : 'Gasto';

  static CategoryType fromString(String value) {
    return value.toLowerCase() == 'income'
        ? CategoryType.income
        : CategoryType.expense;
  }
}

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.icon,
    required this.color,
    required this.isDefault,
    this.createdAt,
  });

  final String id;
  final String userId;
  final String name;
  final CategoryType type;
  final String icon;
  final String color;
  final bool isDefault;
  final DateTime? createdAt;

  bool get isIncome => type == CategoryType.income;
  bool get isExpense => type == CategoryType.expense;

  CategoryEntity copyWith({
    String? id,
    String? userId,
    String? name,
    CategoryType? type,
    String? icon,
    String? color,
    bool? isDefault,
    DateTime? createdAt,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        type,
        icon,
        color,
        isDefault,
        createdAt,
      ];
}
