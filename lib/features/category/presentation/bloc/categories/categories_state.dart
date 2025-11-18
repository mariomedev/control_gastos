part of 'categories_bloc.dart';

enum CategoriesStatus { initial, loading, success, failure }

enum CategoriesMutationStatus { idle, submitting, success, failure }

class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.categories = const <CategoryEntity>[],
    this.errorMessage = '',
    this.mutationStatus = CategoriesMutationStatus.idle,
    this.mutationMessage = '',
  });

  final CategoriesStatus status;
  final List<CategoryEntity> categories;
  final String errorMessage;
  final CategoriesMutationStatus mutationStatus;
  final String mutationMessage;

  List<CategoryEntity> get incomeCategories =>
      categories.where((category) => category.isIncome).toList(growable: false);

  List<CategoryEntity> get expenseCategories => categories
      .where((category) => category.isExpense)
      .toList(growable: false);

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<CategoryEntity>? categories,
    String? errorMessage,
    CategoriesMutationStatus? mutationStatus,
    String? mutationMessage,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
      mutationStatus: mutationStatus ?? this.mutationStatus,
      mutationMessage: mutationMessage ?? this.mutationMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        errorMessage,
        mutationStatus,
        mutationMessage,
      ];
}
