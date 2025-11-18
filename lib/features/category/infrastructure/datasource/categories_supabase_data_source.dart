import 'dart:async';
import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class CategoriesSupabaseDataSource extends CategoriesDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<Either<ErrorItem, List<Map<String, dynamic>>>> getUserCategories(
    String userId,
  ) async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .eq('user_id', userId)
          .order('name', ascending: true);

      final data = (response as List<dynamic>)
          .map(
            (item) => Map<String, dynamic>.from(item as Map<String, dynamic>),
          )
          .toList(growable: false);

      return Either.right(data);
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
  Future<Either<ErrorItem, Map<String, dynamic>>> getCategoryById(
    String categoryId,
  ) async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .eq('id', categoryId)
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
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>>> createCategory(
    CreateCategoryInput input,
  ) async {
    try {
      final response = await _supabase
          .from('categories')
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
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>>> updateCategory(
    UpdateCategoryInput input,
  ) async {
    try {
      final response = await _supabase
          .from('categories')
          .update(input.toMap())
          .eq('id', input.categoryId)
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
    } catch (_) {
      return Either.left(SystemErrors.unknown);
    }
  }

  @override
  Future<Either<ErrorItem, bool>> deleteCategory(String categoryId) async {
    try {
      await _supabase.from('categories').delete().eq('id', categoryId);
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
