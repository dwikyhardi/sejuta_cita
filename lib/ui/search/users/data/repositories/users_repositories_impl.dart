import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sejuta_cita/core/error/exceptions.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/core/network/network_info.dart';
import 'package:sejuta_cita/ui/search/users/data/datasource/users_remote_datasource.dart';
import 'package:sejuta_cita/ui/search/users/domain/entities/users.dart';
import 'package:sejuta_cita/ui/search/users/domain/repositories/users_repositories.dart';

class UserRepositoriesImpl implements UserRepositories {
  final UsersRemoteDatasource datasource;

  final NetworkInfo networkInfo;

  UserRepositoriesImpl({required this.datasource, required this.networkInfo});

  @override
  Future<Either<Failure, Users>> getUsers({
    required String searchKey,
    required int page,
    int? resultCount,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await datasource.getUsers(
          searchKey: searchKey,
          page: page,
          resultCount: resultCount,
        ));
      } else {
        return const Left(ServerFailure(errorMessage: 'No Connection'));
      }
    } catch (e, _) {
      if (e is ServerException) {
        if (e.error is DioError) {
          return Left(ServerFailure(
              errorMessage: (e.error as DioError).message.toString()));
        } else {
          return Left(ServerFailure(errorMessage: e.error.toString()));
        }
      } else {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }
}
