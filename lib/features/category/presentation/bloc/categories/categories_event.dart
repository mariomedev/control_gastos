part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class CategoriesFetchRequested extends CategoriesEvent {
  const CategoriesFetchRequested();
}

class CategoriesRefreshRequested extends CategoriesEvent {
  const CategoriesRefreshRequested();
}

class CategoryCreateRequested extends CategoriesEvent {
  const CategoryCreateRequested({
    required this.name,
    required this.type,
    required this.icon,
    required this.color,
  });

  final String name;
  final CategoryType type;
  final String icon;
  final String color;

  @override
  List<Object?> get props => [name, type, icon, color];
}

class CategoryUpdateRequested extends CategoriesEvent {
  const CategoryUpdateRequested({
    required this.categoryId,
    this.name,
    this.icon,
    this.color,
  });

  final String categoryId;
  final String? name;
  final String? icon;
  final String? color;

  @override
  List<Object?> get props => [categoryId, name, icon, color];
}

class CategoryDeleteRequested extends CategoriesEvent {
  const CategoryDeleteRequested(this.categoryId);

  final String categoryId;

  @override
  List<Object?> get props => [categoryId];
}
