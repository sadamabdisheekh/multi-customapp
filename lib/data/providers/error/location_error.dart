class LocationServiceException implements Exception {
  final int code;
  final String message;

  LocationServiceException(this.code, this.message);

  @override
  String toString() => 'Error $code: $message';
}
