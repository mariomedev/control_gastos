import 'dart:async';
import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class TransactionsSupabaseDataSource extends TransactionsDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<Either<ErrorItem, List<Map<String, dynamic>>>> getUserTransactions(
    String userId,
  ) async {
    try {
      final response = await _supabase.from('transactions').select('''
            *,
            accounts:accounts (id, name, icon, color, type),
            categories:categories (id, name, icon, color)
          ''').eq('user_id', userId).order('date', ascending: false);

      final list = (response as List<dynamic>)
          .map(
              (item) => Map<String, dynamic>.from(item as Map<String, dynamic>))
          .toList(growable: false);

      return Either.right(list);
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>>> getTransactionDetail(
    String transactionId,
  ) async {
    try {
      final response = await _supabase.from('transactions').select('''
            *,
            accounts:accounts (id, name, icon, color, type),
            categories:categories (id, name, icon, color)
          ''').eq('id', transactionId).single();

      return Either.right(Map<String, dynamic>.from(response));
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>>> createTransaction(
    CreateTransactionInput input,
  ) async {
    try {
      final response =
          await _supabase.from('transactions').insert(input.toMap()).select('''
            *,
            accounts:accounts (id, name, icon, color, type),
            categories:categories (id, name, icon, color)
          ''').single();

      return Either.right(Map<String, dynamic>.from(response));
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>>> updateTransaction(
    UpdateTransactionInput input,
  ) async {
    try {
      final response = await _supabase
          .from('transactions')
          .update(input.toMap())
          .eq('id', input.transactionId)
          .select('''
            *,
            accounts:accounts (id, name, icon, color, type),
            categories:categories (id, name, icon, color)
          ''').single();

      return Either.right(Map<String, dynamic>.from(response));
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, bool>> deleteTransaction(
      String transactionId) async {
    try {
      await _supabase.from('transactions').delete().eq('id', transactionId);
      return const Either.right(true);
    } on PostgrestException catch (e) {
      return Either.left(
        ErrorItem(code: e.code ?? 'POSTGREST_ERROR', message: e.message),
      );
    } on SocketException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } on TimeoutException catch (e) {
      return Either.left(SystemErrors.fromException(e));
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }
}
