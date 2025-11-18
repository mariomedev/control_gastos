import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../domain/domain.dart';
import '../bloc/categories/categories_bloc.dart';
import 'widgets/widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final CategoriesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<CategoriesBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _bloc.add(const CategoriesFetchRequested());
    });
  }

  Future<void> _onRefresh() async {
    _bloc.add(const CategoriesRefreshRequested());
    await _bloc.stream.firstWhere(
      (state) => state.status != CategoriesStatus.loading,
    );
  }

  void _openCategoryForm([CategoryEntity? category]) {
    final path = '${RoutePaths.categories}/${RoutePaths.createCategory}';
    context.push(path, extra: category);
  }

  Future<void> _onDeleteCategory(CategoryEntity category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar categoría'),
        content: Text(
          '¿Deseas eliminar "${category.name}"? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _bloc.add(CategoryDeleteRequested(category.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<CategoriesBloc, CategoriesState>(
        listenWhen: (previous, current) =>
            previous.mutationStatus != current.mutationStatus,
        listener: (context, state) {
          if (state.mutationStatus == CategoriesMutationStatus.idle ||
              state.mutationStatus == CategoriesMutationStatus.submitting) {
            return;
          }

          final messenger = ScaffoldMessenger.of(context);
          final isSuccess =
              state.mutationStatus == CategoriesMutationStatus.success;
          final message = state.mutationMessage.isNotEmpty
              ? state.mutationMessage
              : isSuccess
                  ? 'Operación exitosa'
                  : 'Ocurrió un error';

          messenger.showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor:
                  isSuccess ? null : Theme.of(context).colorScheme.error,
            ),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.appBarCategories),
            actions: [
              IconButton(
                onPressed: () => _openCategoryForm(),
                icon: const Icon(Icons.add),
                tooltip: 'Nueva categoría',
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.all(AppDimensions.kPadding20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    _buildBody(state),
                    const SizedBox(height: 24),
                    AddCategoryButton(onPressed: () => _openCategoryForm()),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(CategoriesState state) {
    switch (state.status) {
      case CategoriesStatus.loading:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Center(child: CircularProgressIndicator()),
        );
      case CategoriesStatus.failure:
        return _CategoriesError(
          message: state.errorMessage.isEmpty
              ? 'No se pudieron cargar las categorías'
              : state.errorMessage,
          onRetry: () => _bloc.add(const CategoriesFetchRequested()),
        );
      case CategoriesStatus.success:
        if (state.categories.isEmpty) {
          return const EmptyCategories();
        }
        return CategoryListBuilder(
          categories: state.categories,
          onEdit: (category) => _openCategoryForm(category),
          onDelete: (category) {
            _onDeleteCategory(category);
          },
        );
      case CategoriesStatus.initial:
        return const SizedBox.shrink();
    }
  }
}

class _CategoriesError extends StatelessWidget {
  const _CategoriesError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colors.errorContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ocurrió un error',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(message),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
