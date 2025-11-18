import 'package:get_it/get_it.dart';

import '../domain/domain.dart';
import '../infrastructure/infrastructure.dart';
import '../presentation/bloc/transactions/transactions_bloc.dart';

final locator = GetIt.instance;

Future<void> initGeneralSpendingInjection() async {
  // ═══════════════════════════════════════════════════════════════════════════
  // DATASOURCES
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerSingleton<TransactionsDataSource>(
    TransactionsSupabaseDataSource(),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // REPOSITORIES
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerSingleton<TransactionsRepository>(
    TransactionsRepositoryImpl(
      dataSource: locator<TransactionsDataSource>(),
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerSingleton<GetUserTransactions>(
    GetUserTransactions(locator<TransactionsRepository>()),
  );

  locator.registerSingleton<GetTransactionDetail>(
    GetTransactionDetail(locator<TransactionsRepository>()),
  );

  locator.registerSingleton<CreateTransaction>(
    CreateTransaction(locator<TransactionsRepository>()),
  );

  locator.registerSingleton<UpdateTransaction>(
    UpdateTransaction(locator<TransactionsRepository>()),
  );

  locator.registerSingleton<DeleteTransaction>(
    DeleteTransaction(locator<TransactionsRepository>()),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // BLOCS
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerFactory<TransactionsBloc>(
    () => TransactionsBloc(
      getUserTransactions: locator<GetUserTransactions>(),
      getTransactionDetail: locator<GetTransactionDetail>(),
      createTransaction: locator<CreateTransaction>(),
      updateTransaction: locator<UpdateTransaction>(),
      deleteTransaction: locator<DeleteTransaction>(),
    ),
  );
}
