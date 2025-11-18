import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../entities/create_category_input.dart';
import '../entities/update_category_input.dart';

abstract class CategoriesDataSource {
  Future<Either<ErrorItem, List<Map<String, dynamic>>>> getUserCategories(
    String userId,
  );

  Future<Either<ErrorItem, Map<String, dynamic>>> getCategoryById(
    String categoryId,
  );

  Future<Either<ErrorItem, Map<String, dynamic>>> createCategory(
    CreateCategoryInput input,
  );

  Future<Either<ErrorItem, Map<String, dynamic>>> updateCategory(
    UpdateCategoryInput input,
  );

  Future<Either<ErrorItem, bool>> deleteCategory(String categoryId);
}
