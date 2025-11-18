import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/accounts/accounts_bloc.dart';

class CreateAccountSheet extends StatefulWidget {
  const CreateAccountSheet({super.key});

  @override
  State<CreateAccountSheet> createState() => _CreateAccountSheetState();
}

class _CreateAccountSheetState extends State<CreateAccountSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController(text: 'cash');
  final _balanceController = TextEditingController();
  final _currencyController = TextEditingController(text: 'USD');
  final _iconController = TextEditingController(text: '💵');
  final _colorController = TextEditingController(text: '#00B894');
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _balanceController.dispose();
    _currencyController.dispose();
    _iconController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<AccountsBloc, AccountsState>(
      listenWhen: (previous, current) =>
          previous.mutationStatus != current.mutationStatus,
      listener: (context, state) {
        if (state.mutationStatus == AccountsMutationStatus.success) {
          Navigator.of(context).maybePop();
        }
      },
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: viewInsets + 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Agregar cuenta',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Cuenta de ahorros',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Ingresa un nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _typeController.text,
                    decoration: const InputDecoration(
                      labelText: 'Tipo',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'cash', child: Text('Efectivo')),
                      DropdownMenuItem(value: 'bank', child: Text('Banco')),
                      DropdownMenuItem(
                          value: 'credit_card',
                          child: Text('Tarjeta de crédito')),
                      DropdownMenuItem(value: 'savings', child: Text('Ahorro')),
                      DropdownMenuItem(
                          value: 'investment', child: Text('Inversión')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _typeController.text = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Selecciona un tipo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _balanceController,
                    decoration: const InputDecoration(
                      labelText: 'Saldo inicial',
                      hintText: '0.00',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _currencyController,
                    decoration: const InputDecoration(
                      labelText: 'Moneda',
                      hintText: 'USD',
                    ),
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.next,
                    maxLength: 4,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _iconController,
                    decoration: const InputDecoration(
                      labelText: 'Icono',
                      hintText: '💵',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _colorController,
                    decoration: const InputDecoration(
                      labelText: 'Color (HEX)',
                      hintText: '#00B894',
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile.adaptive(
                    value: _isActive,
                    onChanged: (value) => setState(() => _isActive = value),
                    title: const Text('Cuenta activa'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AccountsBloc, AccountsState>(
                    buildWhen: (previous, current) =>
                        previous.mutationStatus != current.mutationStatus ||
                        previous.mutationMessage != current.mutationMessage,
                    builder: (context, state) {
                      final isSubmitting = state.mutationStatus ==
                          AccountsMutationStatus.submitting;
                      final String? errorText = state.mutationStatus ==
                                  AccountsMutationStatus.failure &&
                              state.mutationMessage.isNotEmpty
                          ? state.mutationMessage
                          : null;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (errorText != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                errorText,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          FilledButton(
                            onPressed: isSubmitting ? null : _submit,
                            child: isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Crear cuenta'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final bloc = context.read<AccountsBloc>();
    final rawBalance = _balanceController.text.replaceAll(',', '.');
    final balance = double.tryParse(rawBalance) ?? 0;
    final currency = _currencyController.text.trim().isEmpty
        ? 'USD'
        : _currencyController.text.trim().toUpperCase();
    final color = _formatHexColor(_colorController.text.trim());
    final icon = _iconController.text.trim().isEmpty
        ? '💵'
        : _iconController.text.trim();

    bloc.add(
      AccountCreateRequested(
        name: _nameController.text.trim(),
        type: _typeController.text.trim(),
        balance: balance,
        currency: currency,
        icon: icon,
        color: color,
        isActive: _isActive,
      ),
    );
  }

  String _formatHexColor(String value) {
    if (value.isEmpty) return '#00B894';
    return value.startsWith('#') ? value : '#$value';
  }
}
