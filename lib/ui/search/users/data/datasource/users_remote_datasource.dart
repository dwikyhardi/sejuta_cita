import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sejuta_cita/core/error/exceptions.dart';
import 'package:sejuta_cita/core/network/dio_client.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/users/data/models/users_model.dart';

abstract class UsersRemoteDatasource {
  Future<UsersModel> getUsers({
    required String searchKey,
    required int page,
    int? resultCount,
  });
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  final DioClient dioClient;

  UsersRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<UsersModel> getUsers(
      {required String searchKey, required int page, int? resultCount}) async {
    try {
      var response = await dioClient.searchData(
        searchType: SearchType.users.toString().replaceAll(
              'SearchType.',
              '',
            ),
        page: page,
        resultCount: resultCount ?? 10,
        searchKey: searchKey,
      );
      if (response.statusCode == 200 && response.data != null) {
        if (response.data?['total_count'] > 0) {
          return UsersModel.fromJson(response.data ?? {});
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
