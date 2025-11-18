import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../domain/domain.dart';
import '../bloc/accounts/accounts_bloc.dart';
import '../widgets/accounts_list.dart';
import '../widgets/create_account_sheet.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  late final AccountsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<AccountsBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _bloc.add(const AccountsFetchRequested());
    });
  }

  Future<void> _onRefresh() async {
    _bloc.add(const AccountsRefreshRequested());
    await _bloc.stream.firstWhere(
      (state) => state.status != AccountsStatus.loading,
    );
  }

  void _onAddAccount() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: _bloc,
        child: const CreateAccountSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<AccountsBloc, AccountsState>(
        listenWhen: (previous, current) =>
            previous.mutationStatus != current.mutationStatus &&
            current.mutationStatus != AccountsMutationStatus.submitting &&
            current.mutationStatus != AccountsMutationStatus.idle,
        listener: (context, state) {
          if (!mounted) return;
          _showMutationSnackBar(context, state);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Cuentas'),
            actions: [
              IconButton(
                onPressed: _onAddAccount,
                icon: const Icon(Icons.add),
                tooltip: 'Agregar cuenta',
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: AccountsList(
                bloc: _bloc,
                onAddAccount: _onAddAccount,
                onDeleteAccount: _onDeleteAccount,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDeleteAccount(AccountEntity account) async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: Text(
          '¿Seguro que deseas eliminar la cuenta "${account.name}"? Esta acción no se puede deshacer.',
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
      _bloc.add(AccountDeleteRequested(account.id));
    }
  }

  void _showMutationSnackBar(BuildContext context, AccountsState state) {
    final messenger = ScaffoldMessenger.of(context);
    final isSuccess = state.mutationStatus == AccountsMutationStatus.success;
    final message = state.mutationMessage.isNotEmpty
        ? state.mutationMessage
        : isSuccess
            ? 'Operación exitosa'
            : 'Ocurrió un error';

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? null : Theme.of(context).colorScheme.error,
      ),
    );
  }
}
