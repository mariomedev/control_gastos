import 'package:get_it/get_it.dart';

import '../accounts_feature.dart';

final locator = GetIt.instance;

Future<void> initAccountsInjection() async {
  // Datasource
  locator.registerLazySingleton<AccountsDataSource>(
    () => AccountsSupabaseDataSource(),
  );

  // Repository
  locator.registerLazySingleton<AccountsRepository>(
    () => AccountsRepositoryImpl(dataSource: locator()),
  );

  // Use cases
  locator.registerLazySingleton<GetUserAccounts>(
    () => GetUserAccounts(locator()),
  );
  locator.registerLazySingleton<CreateAccount>(
    () => CreateAccount(locator()),
  );
  locator.registerLazySingleton<DeleteAccount>(
    () => DeleteAccount(locator()),
  );

  // Bloc
  locator.registerLazySingleton<AccountsBloc>(
    () => AccountsBloc(
      getUserAccounts: locator(),
      createAccount: locator(),
      deleteAccount: locator(),
    ),
  );
}
