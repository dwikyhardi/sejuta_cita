import 'package:dartz/dartz.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/core/usecase/usecase.dart';
import 'package:sejuta_cita/ui/search/issues/domain/usecases/get_issues_list.dart';
import 'package:sejuta_cita/ui/search/users/domain/entities/users.dart';
import 'package:sejuta_cita/ui/search/users/domain/repositories/users_repositories.dart';

class GetUserList implements UseCase<Users, Params> {
  final UserRepositories repositories;

  GetUserList(this.repositories);

  @override
  Future<Either<Failure, Users>> call(Params params) async {
    return await repositories.getUsers(
      searchKey: params.searchKey,
      page: params.page,
      resultCount: params.resultCount,
    );
  }
}
