import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../entities/category_entity.dart';
import '../entities/create_category_input.dart';
import '../repositories/categories_repository.dart';

class CreateCategory {
  CreateCategory(this.repository);

  final CategoriesRepository repository;

  Future<Either<ErrorItem, CategoryEntity>> call(
    CreateCategoryInput input,
  ) async {
    final validationError = _validate(input);
    if (validationError != null) {
      return Either.left(validationError);
    }

    return repository.createCategory(input);
  }

  ErrorItem? _validate(CreateCategoryInput input) {
    final trimmedName = input.name.trim();

    if (trimmedName.isEmpty) {
      return ErrorItem(
        code: 'INVALID_CATEGORY_NAME',
        message: 'El nombre de la categoría es obligatorio.',
      );
    }

    if (trimmedName.length > 30) {
      return ErrorItem(
        code: 'INVALID_CATEGORY_NAME_LENGTH',
        message: 'El nombre debe tener máximo 30 caracteres.',
      );
    }

    final allowedColors = input.color.trim();
    if (!allowedColors.startsWith('#') || allowedColors.length < 4) {
      return ErrorItem(
        code: 'INVALID_CATEGORY_COLOR',
        message: 'El color debe estar en formato hexadecimal.',
      );
    }

    return null;
  }
}
