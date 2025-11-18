import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:control_gastos/core/core.dart';
import 'package:control_gastos/features/accounts/accounts_feature.dart';
import 'package:control_gastos/features/category/presentation/bloc/categories/categories_bloc.dart';
import 'package:control_gastos/features/general_spending/domain/domain.dart';
import 'package:control_gastos/features/general_spending/presentation/bloc/transactions/transactions_bloc.dart';

import 'transaction_account_field.dart';
import 'transaction_actions.dart';
import 'transaction_category_field.dart';
import 'transaction_mutation_feedback.dart';
import 'transaction_type_selector.dart';

class TransactionFormSheet extends StatefulWidget {
  const TransactionFormSheet({
    super.key,
    required this.initialType,
    this.initialTransaction,
  });

  final TransactionType initialType;
  final TransactionEntity? initialTransaction;

  bool get isEdit => initialTransaction != null;

  @override
  State<TransactionFormSheet> createState() => _TransactionFormSheetState();
}

class _TransactionFormSheetState extends State<TransactionFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late TransactionType _type;
  String? _selectedAccountId;
  String? _selectedCategoryId;

  TransactionsBloc get _transactionsBloc => context.read<TransactionsBloc>();
  AccountsBloc get _accountsBloc => context.read<AccountsBloc>();
  CategoriesBloc get _categoriesBloc => context.read<CategoriesBloc>();

  bool get _allowTypeChange => !widget.isEdit;

  @override
  void initState() {
    super.initState();
    final transaction = widget.initialTransaction;
    _type = transaction?.type ?? widget.initialType;
    _selectedDate = transaction?.date ?? DateTime.now();
    _selectedAccountId = transaction?.accountId;
    _selectedCategoryId = transaction?.categoryId;
    _titleController = TextEditingController(text: transaction?.title ?? '');
    _amountController = TextEditingController(
      text: transaction != null ? transaction.amount.toStringAsFixed(2) : '',
    );
    _descriptionController =
        TextEditingController(text: transaction?.description ?? '');
    _ensureDataLoaded();
  }

  void _ensureDataLoaded() {
    final accountsState = _accountsBloc.state;
    if (accountsState.status == AccountsStatus.initial) {
      _accountsBloc.add(const AccountsFetchRequested());
    }

    final categoriesState = _categoriesBloc.state;
    if (categoriesState.status == CategoriesStatus.initial) {
      _categoriesBloc.add(const CategoriesFetchRequested());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<TransactionsBloc, TransactionsState>(
      listenWhen: (previous, current) =>
          previous.mutationStatus != current.mutationStatus,
      listener: (context, state) {
        if (state.mutationStatus == TransactionMutationStatus.success) {
          Navigator.of(context).maybePop();
        }
      },
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: viewInsets + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isEdit ? 'Editar transacción' : 'Nueva transacción',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const TransactionMutationFeedback(),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TransactionTypeSelector(
                        selectedType: _type,
                        allowTypeChange: _allowTypeChange,
                        showTypeIcon: !widget.isEdit,
                        onChanged: (value) => setState(() {
                          _type = value;
                          _selectedCategoryId = null;
                        }),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Título',
                          hintText: 'Ej. Almuerzo',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa un título';
                          }
                          if (value.trim().length > 100) {
                            return 'Máximo 100 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Monto',
                          prefixText: r'$',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          final parsed = double.tryParse(
                                value?.replaceAll(',', '.') ?? '',
                              ) ??
                              0;
                          if (parsed <= 0) {
                            return 'El monto debe ser mayor a 0';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TransactionAccountField(
                        selectedAccountId: _selectedAccountId,
                        onChanged: (value) => setState(() {
                          _selectedAccountId = value;
                        }),
                      ),
                      const SizedBox(height: 12),
                      TransactionCategoryField(
                        selectedType: _type,
                        selectedCategoryId: _selectedCategoryId,
                        onChanged: (value) => setState(() {
                          _selectedCategoryId = value;
                        }),
                      ),
                      const SizedBox(height: 12),
                      _buildDateField(context),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Descripción (opcional)',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<TransactionsBloc, TransactionsState>(
                        buildWhen: (previous, current) =>
                            previous.mutationStatus != current.mutationStatus,
                        builder: (context, state) {
                          final isSubmitting = state.mutationStatus ==
                              TransactionMutationStatus.submitting;
                          return TransactionActions(
                            isSubmitting: isSubmitting,
                            isEdit: widget.isEdit,
                            onCancel: () => Navigator.of(context).maybePop(),
                            onSubmit: _submit,
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Fecha'),
      subtitle: Text(formatFullDate(_selectedDate)),
      trailing: FilledButton.tonalIcon(
        onPressed: _pickDate,
        icon: const Icon(Icons.calendar_month),
        label: const Text('Cambiar'),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.parse(
      _amountController.text.replaceAll(',', '.').trim(),
    );

    if (widget.isEdit) {
      _transactionsBloc.add(
        TransactionUpdateRequested(
          transactionId: widget.initialTransaction!.id,
          accountId: _selectedAccountId!,
          categoryId: _selectedCategoryId,
          title: _titleController.text.trim(),
          amount: amount,
          date: _selectedDate,
          type: widget.initialTransaction!.type,
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        ),
      );
    } else {
      _transactionsBloc.add(
        TransactionCreateRequested(
          accountId: _selectedAccountId!,
          categoryId: _selectedCategoryId,
          title: _titleController.text.trim(),
          amount: amount,
          date: _selectedDate,
          type: _type,
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        ),
      );
    }
  }
}
