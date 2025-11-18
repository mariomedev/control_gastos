import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../repositories/categories_repository.dart';

class DeleteCategory {
  DeleteCategory(this.repository);

  final CategoriesRepository repository;

  Future<Either<ErrorItem, bool>> call(String categoryId) async {
    if (categoryId.trim().isEmpty) {
      return Either.left(
        ErrorItem(
          code: 'INVALID_CATEGORY_ID',
          message: 'La categoría seleccionada no es válida.',
        ),
      );
    }

    final categoryResult = await repository.getCategoryById(categoryId);

    return categoryResult.fold(
      ifLeft: Either.left,
      ifRight: (category) async {
        if (category.isDefault) {
          return Either.left(
            ErrorItem(
              code: 'DEFAULT_CATEGORY_DELETE',
              message: 'No puedes eliminar categorías por defecto.',
            ),
          );
        }

        return repository.deleteCategory(categoryId);
      },
    );
  }
}
