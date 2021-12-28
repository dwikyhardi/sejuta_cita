import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sejuta_cita/core/error/exceptions.dart';
import 'package:sejuta_cita/core/error/failure.dart';
import 'package:sejuta_cita/core/network/network_info.dart';
import 'package:sejuta_cita/ui/search/repo/data/datasource/repository_remote_datasource.dart';
import 'package:sejuta_cita/ui/search/repo/domain/entities/repository.dart';
import 'package:sejuta_cita/ui/search/repo/domain/repositories/repository_repositories.dart';

class RepositoryRepositoriesImpl implements RepositoryRepositories {
  final RepositoryRemoteDatasource datasource;
  final NetworkInfo networkInfo;

  RepositoryRepositoriesImpl({required this.datasource,required this.networkInfo,});

  @override
  Future<Either<Failure, Repository>> getRepository({
    required String searchKey,
    required int page,
    int? resultCount,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await datasource.getRepository(
          searchKey: searchKey,
          page: page,
          resultCount: resultCount,
        ));
      } else {
        return const Left(ServerFailure(errorMessage: 'No Connection'));
      }
    } catch (e, stackTrace) {
      debugPrint('stackTrace ============= $stackTrace');
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
