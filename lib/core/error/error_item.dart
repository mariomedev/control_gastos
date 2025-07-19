class ErrorItem {
  final String code;
  final String message;
  final dynamic rawError;

  const ErrorItem({
    required this.code,
    required this.message,
    this.rawError,
  });

  @override
  String toString() => '[$code] $message';
}
