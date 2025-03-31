class ServerException implements Exception {
  final String message;
  const ServerException([this.message = "Something went wrong"]);

  @override
  String toString() => "ServerException: $message";
}