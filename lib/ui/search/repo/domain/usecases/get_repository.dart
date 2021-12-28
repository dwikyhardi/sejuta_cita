import 'package:dartz/dartz.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/core/usecase/usecase.dart';
import 'package:sejuta_cita/ui/search/issues/domain/usecases/get_issues_list.dart';
import 'package:sejuta_cita/ui/search/repo/domain/entities/repository.dart';
import 'package:sejuta_cita/ui/search/repo/domain/repositories/repository_repositories.dart';

class GetRepository implements UseCase<Repository, Params> {
  final RepositoryRepositories repositories;

  GetRepository(this.repositories);

  @override
  Future<Either<Failure, Repository>> call(Params params) async {
    return await repositories.getRepository(
      searchKey: params.searchKey,
      page: params.page,
      resultCount: params.resultCount,
    );
  }
}
