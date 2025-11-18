import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../entities/update_category_input.dart';
import '../repositories/categories_repository.dart';

class UpdateCategory {
  UpdateCategory(this.repository);

  final CategoriesRepository repository;

  Future<Either<ErrorItem, CategoryEntity>> call(
    UpdateCategoryInput input,
  ) async {
    final validationError = _validate(input);
    if (validationError != null) {
      return Either.left(validationError);
    }

    return repository.updateCategory(input);
  }

  ErrorItem? _validate(UpdateCategoryInput input) {
    if (input.categoryId.trim().isEmpty) {
      return ErrorItem(
        code: 'INVALID_CATEGORY_ID',
        message: 'La categoría seleccionada no es válida.',
      );
    }

    if (!input.hasChanges) {
      return ErrorItem(
        code: 'CATEGORY_NO_CHANGES',
        message: 'Debes modificar al menos un campo.',
      );
    }

    final name = input.name?.trim();
    if (name != null && name.isEmpty) {
      return ErrorItem(
        code: 'INVALID_CATEGORY_NAME',
        message: 'El nombre de la categoría es obligatorio.',
      );
    }

    if (name != null && name.length > 30) {
      return ErrorItem(
        code: 'INVALID_CATEGORY_NAME_LENGTH',
        message: 'El nombre debe tener máximo 30 caracteres.',
      );
    }

    final color = input.color?.trim();
    if (color != null && (!color.startsWith('#') || color.length < 4)) {
      return ErrorItem(
        code: 'INVALID_CATEGORY_COLOR',
        message: 'El color debe estar en formato hexadecimal.',
      );
    }

    return null;
  }
}
