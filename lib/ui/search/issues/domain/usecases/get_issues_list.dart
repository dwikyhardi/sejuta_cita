import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/core/usecase/usecase.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';
import 'package:sejuta_cita/ui/search/issues/domain/repositories/issues_repositories.dart';

class GetIssuesList implements UseCase<Issues, Params> {
  final IssuesRepositories repositories;

  GetIssuesList(this.repositories);

  @override
  Future<Either<Failure, Issues>> call(Params params) async {
    return await repositories.getIssuesList(
      searchKey: params.searchKey,
      page: params.page,
      resultCount: params.resultCount,
    );
  }
}

class Params extends Equatable {
  final String searchKey;
  final int page;
  final int? resultCount;

  const Params({
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
        searchKey,
        page,
    resultCount,
      ];
}
