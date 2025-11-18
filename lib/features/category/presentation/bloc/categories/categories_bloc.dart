import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/domain.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({
    required GetUserCategories getUserCategories,
    required CreateCategory createCategory,
    required UpdateCategory updateCategory,
    required DeleteCategory deleteCategory,
  })  : _getUserCategories = getUserCategories,
        _createCategory = createCategory,
        _updateCategory = updateCategory,
        _deleteCategory = deleteCategory,
        super(const CategoriesState()) {
    on<CategoriesFetchRequested>(_onFetchRequested);
    on<CategoriesRefreshRequested>(_onRefreshRequested);
    on<CategoryCreateRequested>(_onCreateRequested);
    on<CategoryUpdateRequested>(_onUpdateRequested);
    on<CategoryDeleteRequested>(_onDeleteRequested);
  }

  final GetUserCategories _getUserCategories;
  final CreateCategory _createCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;

  Future<void> _onFetchRequested(
    CategoriesFetchRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    await _loadCategories(emit, forceLoading: true);
  }

  Future<void> _onRefreshRequested(
    CategoriesRefreshRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    await _loadCategories(emit, forceLoading: true);
  }

  Future<void> _loadCategories(
    Emitter<CategoriesState> emit, {
    required bool forceLoading,
  }) async {
    if (forceLoading) {
      emit(state.copyWith(status: CategoriesStatus.loading));
    }

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      emit(
        state.copyWith(
          status: CategoriesStatus.failure,
          errorMessage: 'Usuario no autenticado',
        ),
      );
      return;
    }

    final result = await _getUserCategories(userId);

    result.fold(
      ifLeft: (error) => emit(
        state.copyWith(
          status: CategoriesStatus.failure,
          errorMessage: error.message,
        ),
      ),
      ifRight: (categories) => emit(
        state.copyWith(
          status: CategoriesStatus.success,
          categories: categories,
          errorMessage: '',
        ),
      ),
    );
  }

  Future<void> _onCreateRequested(
    CategoryCreateRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    _setMutationState(emit, CategoriesMutationStatus.submitting);

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      _setMutationState(
        emit,
        CategoriesMutationStatus.failure,
        message: 'Usuario no autenticado',
      );
      _setMutationState(emit, CategoriesMutationStatus.idle);
      return;
    }

    final input = CreateCategoryInput(
      userId: userId,
      name: event.name,
      type: event.type,
      icon: event.icon,
      color: event.color,
    );

    final result = await _createCategory(input);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _setMutationState(
          emit,
          CategoriesMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadCategories(emit, forceLoading: false);
        _setMutationState(
          emit,
          CategoriesMutationStatus.success,
          message: 'Categoría creada correctamente',
        );
      },
    );

    _setMutationState(emit, CategoriesMutationStatus.idle);
  }

  Future<void> _onUpdateRequested(
    CategoryUpdateRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    _setMutationState(emit, CategoriesMutationStatus.submitting);

    final input = UpdateCategoryInput(
      categoryId: event.categoryId,
      name: event.name,
      icon: event.icon,
      color: event.color,
    );

    final result = await _updateCategory(input);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _setMutationState(
          emit,
          CategoriesMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadCategories(emit, forceLoading: false);
        _setMutationState(
          emit,
          CategoriesMutationStatus.success,
          message: 'Categoría actualizada',
        );
      },
    );

    _setMutationState(emit, CategoriesMutationStatus.idle);
  }

  Future<void> _onDeleteRequested(
    CategoryDeleteRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    _setMutationState(emit, CategoriesMutationStatus.submitting);

    final result = await _deleteCategory(event.categoryId);

    await result.fold<Future<void>>(
      ifLeft: (error) async {
        _setMutationState(
          emit,
          CategoriesMutationStatus.failure,
          message: error.message,
        );
      },
      ifRight: (_) async {
        await _loadCategories(emit, forceLoading: false);
        _setMutationState(
          emit,
          CategoriesMutationStatus.success,
          message: 'Categoría eliminada',
        );
      },
    );

    _setMutationState(emit, CategoriesMutationStatus.idle);
  }

  void _setMutationState(
    Emitter<CategoriesState> emit,
    CategoriesMutationStatus status, {
    String message = '',
  }) {
    emit(
      state.copyWith(
        mutationStatus: status,
        mutationMessage: message,
      ),
    );
  }
}
