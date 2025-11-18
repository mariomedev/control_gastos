import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class GetUserCategories {
  GetUserCategories(this.repository);

  final CategoriesRepository repository;

  Future<Either<ErrorItem, List<CategoryEntity>>> call(String userId) {
    return repository.getUserCategories(userId);
  }
}
