import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../entities/create_category_input.dart';
import '../entities/update_category_input.dart';

abstract class CategoriesRepository {
  Future<Either<ErrorItem, List<CategoryEntity>>> getUserCategories(
    String userId,
  );

  Future<Either<ErrorItem, CategoryEntity>> getCategoryById(String categoryId);

  Future<Either<ErrorItem, CategoryEntity>> createCategory(
    CreateCategoryInput input,
  );

  Future<Either<ErrorItem, CategoryEntity>> updateCategory(
    UpdateCategoryInput input,
  );

  Future<Either<ErrorItem, bool>> deleteCategory(String categoryId);
}
