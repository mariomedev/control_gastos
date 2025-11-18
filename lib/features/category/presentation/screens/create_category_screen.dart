import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../bloc/categories/categories_bloc.dart';
import 'widgets/widgets.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key, this.initialCategory});

  final CategoryEntity? initialCategory;

  bool get isEditing => initialCategory != null;

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  late final CategoriesBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _iconController;
  late final TextEditingController _colorController;
  late CategoryType _type;

  static const _colorSuggestions = [
    '#FF6B6B',
    '#4ECDC4',
    '#45B7D1',
    '#96CEB4',
    '#FFEAA7',
    '#DFE6E9',
    '#FAB1A0',
    '#A29BFE',
  ];

  bool get _isEditing => widget.isEditing;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<CategoriesBloc>();
    final initial = widget.initialCategory;
    _nameController = TextEditingController(text: initial?.name ?? '');
    _iconController = TextEditingController(text: initial?.icon ?? '📁');
    _colorController = TextEditingController(text: initial?.color ?? '#A29BFE');
    _type = initial?.type ?? CategoryType.expense;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _iconController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final icon = _iconController.text.trim().isEmpty
        ? '📁'
        : _iconController.text.trim();
    final color = _normalizeColor(_colorController.text.trim());

    if (_isEditing) {
      final category = widget.initialCategory!;
      final updatedName = name != category.name ? name : null;
      final updatedIcon = icon != category.icon ? icon : null;
      final updatedColor = color != category.color ? color : null;

      _bloc.add(
        CategoryUpdateRequested(
          categoryId: category.id,
          name: updatedName,
          icon: updatedIcon,
          color: updatedColor,
        ),
      );
    } else {
      _bloc.add(
        CategoryCreateRequested(
          name: name,
          type: _type,
          icon: icon,
          color: color,
        ),
      );
    }
  }

  String _normalizeColor(String value) {
    if (value.isEmpty) return '#A29BFE';
    final sanitized = value.startsWith('#') ? value : '#$value';
    return sanitized.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        _isEditing ? 'Editar categoría' : AppStrings.appBarCreateCategory;

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<CategoriesBloc, CategoriesState>(
        listenWhen: (previous, current) =>
            previous.mutationStatus != current.mutationStatus,
        listener: (context, state) {
          if (state.mutationStatus == CategoriesMutationStatus.success) {
            Navigator.of(context).maybePop();
          } else if (state.mutationStatus == CategoriesMutationStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.mutationMessage)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.kPadding20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        hintText: 'Alimentación',
                      ),
                      maxLength: 30,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ingresa un nombre';
                        }
                        if (value.trim().length > 30) {
                          return 'Máximo 30 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CategoryTypeSelector(
                      selectedType: _type,
                      isEditing: _isEditing,
                      onChanged: _isEditing
                          ? null
                          : (type) => setState(() => _type = type),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _iconController,
                      decoration: const InputDecoration(
                        labelText: 'Icono (emoji)',
                        hintText: '📁',
                      ),
                      textCapitalization: TextCapitalization.none,
                      maxLength: 4,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _colorController,
                      decoration: const InputDecoration(
                        labelText: 'Color (HEX)',
                        hintText: '#A29BFE',
                      ),
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        final normalized =
                            value.startsWith('#') ? value : '#$value';
                        if (normalized.length < 4) {
                          return 'Color no válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CategoryColorSuggestions(
                      colorOptions: _colorSuggestions,
                      selectedColor: _normalizeColor(_colorController.text),
                      onColorSelected: (color) => setState(() {
                        _colorController.text = color;
                      }),
                    ),
                    const SizedBox(height: 32),
                    CategorySubmitButton(
                      isEditing: _isEditing,
                      createLabel: AppStrings.buttonCreateCategory,
                      onSubmit: _submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
