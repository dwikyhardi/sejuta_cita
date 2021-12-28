import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sejuta_cita/core/network/dio_client.dart';
import 'package:sejuta_cita/core/network/dio_service.dart';
import 'package:sejuta_cita/core/network/launch_another_apps.dart';
import 'package:sejuta_cita/core/network/network_info.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/issues/data/datasource/issues_remote_data_source.dart';
import 'package:sejuta_cita/ui/search/issues/data/repositories/issues_repositories_impl.dart';
import 'package:sejuta_cita/ui/search/issues/domain/repositories/issues_repositories.dart';
import 'package:sejuta_cita/ui/search/issues/domain/usecases/get_issues_list.dart';
import 'package:sejuta_cita/ui/search/issues/presentation/bloc/issues_bloc.dart';
import 'package:sejuta_cita/ui/search/repo/data/datasource/repository_remote_datasource.dart';
import 'package:sejuta_cita/ui/search/repo/data/repositories/repository_repositories_impl.dart';
import 'package:sejuta_cita/ui/search/repo/domain/repositories/repository_repositories.dart';
import 'package:sejuta_cita/ui/search/repo/domain/usecases/get_repository.dart';
import 'package:sejuta_cita/ui/search/repo/presentation/bloc/repository_bloc.dart';
import 'package:sejuta_cita/ui/search/users/data/datasource/users_remote_datasource.dart';
import 'package:sejuta_cita/ui/search/users/data/repositories/users_repositories_impl.dart';
import 'package:sejuta_cita/ui/search/users/domain/repositories/users_repositories.dart';
import 'package:sejuta_cita/ui/search/users/domain/usecases/get_user_list.dart';
import 'package:sejuta_cita/ui/search/users/presentation/bloc/users_bloc.dart';

var sl = GetIt.instance;

Future<void> init() async {
  ///Dashboard
  sl.registerFactory(() => DashboardBloc());

  ///Issues
  //BLoC
  sl.registerFactory(() => IssuesBloc(
        getIssuesList: sl(),
      ));

  //UseCase
  sl.registerLazySingleton(() => GetIssuesList(sl()));

  //Repositories
  sl.registerLazySingleton<IssuesRepositories>(() => IssuesRepositoriesImpl(
        dataSourceImpl: sl(),
        networkInfo: sl(),
      ));

  //DataSource
  sl.registerLazySingleton<IssuesRemoteDataSource>(
      () => IssuesRemoteDataSourceImpl(dioClient: sl()));

  ///Users
  //BLoC
  sl.registerFactory(() => UsersBloc(
        getUsersList: sl(),
      ));

  //UseCase
  sl.registerLazySingleton(() => GetUserList(sl()));

  //Repositories
  sl.registerLazySingleton<UserRepositories>(() => UserRepositoriesImpl(
        datasource: sl(),
        networkInfo: sl(),
      ));

  //DataSource
  sl.registerLazySingleton<UsersRemoteDatasource>(
      () => UsersRemoteDatasourceImpl(
            dioClient: sl(),
          ));

  ///Repository
  //BLoC
  sl.registerFactory(() => RepositoryBloc(getRepositoryList: sl()));

  //UseCase
  sl.registerLazySingleton(() => GetRepository(sl()));

  //Repository
  sl.registerLazySingleton<RepositoryRepositories>(
      () => RepositoryRepositoriesImpl(
            datasource: sl(),
            networkInfo: sl(),
          ));

  //DataSource
  sl.registerLazySingleton<RepositoryRemoteDatasource>(
      () => RepositoryRemoteDatasourceImpl(
            dioClient: sl(),
          ));

  ///Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        sl(),
      ));

  ///External
  final Dio dio = await DioService.setupDio();
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton(() => DioClient(
        sl(),
      ));
  sl.registerLazySingleton(() => LaunchAnotherApp());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
