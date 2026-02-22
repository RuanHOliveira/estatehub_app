class AppException implements Exception {
  final String errorCode;
  final int? statusCode;

  const AppException({
    required this.errorCode,
    this.statusCode,
  });

  factory AppException.unknown() {
    return const AppException(errorCode: 'ErrUnknown');
  }

  @override
  String toString() => errorCode;
}
