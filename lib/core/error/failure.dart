import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
        );

  @override
  List<Object> get props => [errorMessage];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required String errorMessage,
  }) : super(
          errorMessage: errorMessage,
        );

  @override
  List<Object> get props => [errorMessage];
}
