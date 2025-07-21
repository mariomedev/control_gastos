import 'package:control_gastos/core/error/failure.dart';

class ErrorItem extends Failure {
  final String code;

  ErrorItem({
    required this.code,
    required String message,
  }) : super(message);

  @override
  String toString() => 'ErrorItem(code: $code, message: $message)';
}
