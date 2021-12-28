import 'package:dio/dio.dart';

class ServerException implements Exception {
  final Exception error;
  final StackTrace stackTrace;
  ServerException(this.error, this.stackTrace);
}

class DatabaseException implements Exception {}
