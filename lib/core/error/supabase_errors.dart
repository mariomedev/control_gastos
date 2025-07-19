import 'package:supabase_flutter/supabase_flutter.dart';
import 'error_item.dart';

class SupabaseErrors {
  static const userNotFound = ErrorItem(
    code: 'USER_NOT_FOUND',
    message: 'No se encontró un usuario con esas credenciales.',
  );

  static const invalidCredentials = ErrorItem(
    code: 'INVALID_CREDENTIALS',
    message: 'Correo o contraseña incorrectos.',
  );

  static const emailNotConfirmed = ErrorItem(
    code: 'EMAIL_NOT_CONFIRMED',
    message: 'Debes confirmar tu correo electrónico antes de iniciar sesión.',
  );

  static const userAlreadyExists = ErrorItem(
    code: 'USER_ALREADY_EXISTS',
    message: 'Ya existe una cuenta con este correo.',
  );

  static const invalidEmail = ErrorItem(
    code: 'INVALID_EMAIL',
    message: 'El formato del correo electrónico no es válido.',
  );

  static const passwordTooWeak = ErrorItem(
    code: 'WEAK_PASSWORD',
    message: 'La contraseña es demasiado débil.',
  );

  static const rateLimitExceeded = ErrorItem(
    code: 'RATE_LIMIT',
    message: 'Demasiados intentos. Intenta más tarde.',
  );

  static const unknown = ErrorItem(
    code: 'UNKNOWN',
    message: 'Ha ocurrido un error inesperado.',
  );

  static ErrorItem fromException(dynamic error) {
    if (error is AuthException) {
      final msg = error.message.toLowerCase();

      if (msg.contains('invalid login credentials')) {
        return invalidCredentials;
      }
      if (msg.contains('user not found')) {
        return userNotFound;
      }
      if (msg.contains('email not confirmed')) {
        return emailNotConfirmed;
      }
      if (msg.contains('user already registered')) {
        return userAlreadyExists;
      }
      if (msg.contains('invalid email')) {
        return invalidEmail;
      }
      if (msg.contains('password should be at least')) {
        return passwordTooWeak;
      }
      if (msg.contains('rate limit')) {
        return rateLimitExceeded;
      }

      // Si no es ninguna conocida
      return ErrorItem(
        code: 'AUTH_EXCEPTION',
        message: error.message,
        rawError: error,
      );
    }

    return unknown;
  }
}
