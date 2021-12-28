import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sejuta_cita/core/error/exceptions.dart';
import 'package:sejuta_cita/core/network/dio_client.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/issues/data/models/issues_model.dart';

abstract class IssuesRemoteDataSource {
  Future<IssuesModel> getIssues({
    required String searchKey,
    required int page,
    int? resultCount,
  });
}

class IssuesRemoteDataSourceImpl implements IssuesRemoteDataSource {
  final DioClient dioClient;

  IssuesRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<IssuesModel> getIssues(
      {required String searchKey, required int page, int? resultCount}) async {
    try {
      var response = await dioClient.searchData(
        searchType: SearchType.issues.toString().replaceAll(
              'SearchType.',
              '',
            ),
        page: page,
        resultCount: resultCount,
        searchKey: searchKey,
      );
      if (response.statusCode == 200 && response.data != null) {
        if (response.data?['total_count'] > 0) {
          return IssuesModel.fromJson(response.data ?? {});
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
