import 'package:dartz/dartz.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/ui/search/repo/domain/entities/repository.dart';

abstract class RepositoryRepositories {
  Future<Either<Failure, Repository>> getRepository({
    required String searchKey,
    required int page,
    int? resultCount,
  });
}
