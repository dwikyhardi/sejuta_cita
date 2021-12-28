import 'package:dartz/dartz.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';

abstract class IssuesRepositories {
  Future<Either<Failure, Issues>> getIssuesList({
    required String searchKey,
    required int page,
    int? resultCount,
  });
}
