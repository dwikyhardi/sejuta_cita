import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sejuta_cita/core/error/exceptions.dart';
import 'package:sejuta_cita/core/network/dio_client.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/repo/data/models/repository_model.dart';

abstract class RepositoryRemoteDatasource {
  Future<RepositoryModel> getRepository({
    required String searchKey,
    required int page,
    int? resultCount,
  });
}

class RepositoryRemoteDatasourceImpl implements RepositoryRemoteDatasource {
  final DioClient dioClient;

  RepositoryRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<RepositoryModel> getRepository(
      {required String searchKey, required int page, int? resultCount}) async {
    try {
      var response = await dioClient.searchData(
        searchType: SearchType.repositories.toString().replaceAll(
              'SearchType.',
              '',
            ),
        page: page,
        resultCount: resultCount ?? 10,
        searchKey: searchKey,
      );
      if (response.statusCode == 200 && response.data != null) {
        if (response.data?['total_count'] > 0) {
          return RepositoryModel.fromJson(response.data ?? {});
        } else {
          throw ServerException(Exception('Empty Data'),
              StackTrace.fromString('Data From Server is 0'));
        }
      } else {
        throw ServerException(
            Exception('Response != 200 : ${response.statusCode}'),
            StackTrace.fromString('Response != 200 : ${response.statusCode}'));
      }
    } catch (e, stackTrace) {
      debugPrint('stackTrace ========== $stackTrace');
      rethrow;
    }
  }
}
