import 'dart:io';
import 'dart:async';

import 'error_item.dart';

class SystemErrors {
  static final noInternet = ErrorItem(
    code: 'NO_INTERNET',
    message: 'No hay conexión a Internet.',
  );

  static final timeout = ErrorItem(
    code: 'TIMEOUT',
    message: 'La solicitud ha tardado demasiado.',
  );

  static final unknown = ErrorItem(
    code: 'SYSTEM_UNKNOWN',
    message: 'Ocurrió un error inesperado del sistema.',
  );

  static ErrorItem fromException(dynamic error) {
    if (error is SocketException) {
      return noInternet;
    }

    if (error is TimeoutException) {
      return timeout;
    }

    return unknown;
  }
}
