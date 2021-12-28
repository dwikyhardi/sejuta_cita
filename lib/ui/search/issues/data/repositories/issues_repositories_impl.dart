import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sejuta_cita/core/error/exceptions.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/core/network/network_info.dart';
import 'package:sejuta_cita/ui/search/issues/data/datasource/issues_remote_data_source.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';
import 'package:sejuta_cita/ui/search/issues/domain/repositories/issues_repositories.dart';

class IssuesRepositoriesImpl implements IssuesRepositories {
  final IssuesRemoteDataSource dataSourceImpl;
  final NetworkInfo networkInfo;

  IssuesRepositoriesImpl({
    required this.dataSourceImpl,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Issues>> getIssuesList(
      {required String searchKey, required int page, int? resultCount}) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await dataSourceImpl.getIssues(
          searchKey: searchKey,
          page: page,
          resultCount: resultCount,
        ));
      } else {
        return const Left(ServerFailure(errorMessage: 'No Connection'));
      }
    } catch (e, stackTrace) {
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
