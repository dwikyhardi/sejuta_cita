import 'package:dartz/dartz.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/ui/search/users/domain/entities/users.dart';

abstract class UserRepositories {
  Future<Either<Failure, Users>> getUsers({
    required String searchKey,
    required int page,
    int? resultCount,
  });
}
