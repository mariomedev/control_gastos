import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../mappers/category_mapper.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  CategoriesRepositoryImpl({required this.dataSource});

  final CategoriesDataSource dataSource;

  @override
  Future<Either<ErrorItem, List<CategoryEntity>>> getUserCategories(
    String userId,
  ) async {
    final result = await dataSource.getUserCategories(userId);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (categoryMap) {
        final categories =
            categoryMap.map(CategoryMapper.fromMap).toList(growable: false);
        return Either.right(categories);
      },
    );
  }

  @override
  Future<Either<ErrorItem, CategoryEntity>> getCategoryById(
    String categoryId,
  ) async {
    final result = await dataSource.getCategoryById(categoryId);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (categoryMap) =>
          Either.right(CategoryMapper.fromMap(categoryMap)),
    );
  }

  @override
  Future<Either<ErrorItem, CategoryEntity>> createCategory(
    CreateCategoryInput input,
  ) async {
    final result = await dataSource.createCategory(input);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (newCategory) =>
          Either.right(CategoryMapper.fromMap(newCategory)),
    );
  }

  @override
  Future<Either<ErrorItem, CategoryEntity>> updateCategory(
    UpdateCategoryInput input,
  ) async {
    final result = await dataSource.updateCategory(input);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (updatedCategory) =>
          Either.right(CategoryMapper.fromMap(updatedCategory)),
    );
  }

  @override
  Future<Either<ErrorItem, bool>> deleteCategory(String categoryId) {
    return dataSource.deleteCategory(categoryId);
  }
}
