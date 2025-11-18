import 'dart:async';
import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/core.dart';
import '../../accounts_feature.dart';

class AccountsSupabaseDataSource extends AccountsDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<Either<ErrorItem, List<Map<String, dynamic>>>> getUserAccounts(
    String userId,
  ) async {
    try {
      final response = await _supabase
          .from('accounts')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final list = (response as List<dynamic>)
          .map(
              (item) => Map<String, dynamic>.from(item as Map<String, dynamic>))
          .toList();

      return Either.right(list);
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (e) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>>> createAccount(
    CreateAccountInput input,
  ) async {
    try {
      final response = await _supabase
          .from('accounts')
          .insert(input.toMap())
          .select()
          .single();

      return Either.right(Map<String, dynamic>.from(response));
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (e) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, bool>> deleteAccount(String accountId) async {
    try {
      await _supabase.from('accounts').delete().eq('id', accountId);
      return const Either.right(true);
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (e) {
      return Either.left(SystemErrors.unknown);
    }
  }
}
