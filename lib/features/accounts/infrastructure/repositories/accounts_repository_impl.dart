import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../mappers/account_mapper.dart';

class AccountsRepositoryImpl extends AccountsRepository {
  final AccountsDataSource dataSource;

  AccountsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ErrorItem, List<AccountEntity>>> getUserAccounts(
    String userId,
  ) async {
    final result = await dataSource.getUserAccounts(userId);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (rows) {
        final entities =
            rows.map(AccountMapper.fromMap).toList(growable: false);
        return Either.right(entities);
      },
    );
  }

  @override
  Future<Either<ErrorItem, AccountEntity>> createAccount(
    CreateAccountInput input,
  ) async {
    final result = await dataSource.createAccount(input);

    return result.fold(
      ifLeft: Either.left,
      ifRight: (account) => Either.right(AccountMapper.fromMap(account)),
    );
  }

  @override
  Future<Either<ErrorItem, bool>> deleteAccount(String accountId) {
    return dataSource.deleteAccount(accountId);
  }
}
