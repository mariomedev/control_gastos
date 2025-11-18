import 'package:get_it/get_it.dart';

import '../domain/domain.dart';
import '../infrastructure/datasource/categories_supabase_data_source.dart';
import '../infrastructure/repositories/categories_repository_impl.dart';
import '../presentation/bloc/categories/categories_bloc.dart';

final _locator = GetIt.instance;

Future<void> initCategoryInjection() async {
  _locator.registerLazySingleton<CategoriesDataSource>(
    () => CategoriesSupabaseDataSource(),
  );

  _locator.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(dataSource: _locator()),
  );

  _locator.registerLazySingleton<GetUserCategories>(
    () => GetUserCategories(_locator()),
  );
  _locator.registerLazySingleton<CreateCategory>(
    () => CreateCategory(_locator()),
  );
  _locator.registerLazySingleton<UpdateCategory>(
    () => UpdateCategory(_locator()),
  );
  _locator.registerLazySingleton<DeleteCategory>(
    () => DeleteCategory(_locator()),
  );

  _locator.registerLazySingleton<CategoriesBloc>(
    () => CategoriesBloc(
      getUserCategories: _locator(),
      createCategory: _locator(),
      updateCategory: _locator(),
      deleteCategory: _locator(),
    ),
  );
}
