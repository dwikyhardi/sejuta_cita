import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav_router/nav_router.dart';
import 'package:sejuta_cita/ui/search/issues/presentation/bloc/issues_bloc.dart';
import 'package:sejuta_cita/ui/search/repo/presentation/bloc/repository_bloc.dart';
import 'package:sejuta_cita/ui/search/users/presentation/bloc/users_bloc.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

enum SearchType {
  users,
  repositories,
  issues,
}

enum LoadType {
  lazyLoading,
  withIndex,
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc()
      : super(const DashboardInitial(selectedSearchType: SearchType.users)) {
    on<DashboardEvent>((event, emit) {});
    on<ChangeSearchType>((event, emit) => onChangeSearchType(event, emit));
    on<InitSearch>((event, emit) => onInitSearch(event, emit));
    on<SearchData>((event, emit) => onSearchData(event, emit));
  }

  Future<void> onChangeSearchType(
      ChangeSearchType event, Emitter<DashboardState> emitter) async {
    debugPrint(event.selectedSearchType.toString());
    emitter(DashboardInitial(selectedSearchType: event.selectedSearchType));
  }

  Future<void> onInitSearch(
    InitSearch event,
    Emitter<DashboardState> emitter,
  ) async {
    switch (event.selectedSearchType) {
      case SearchType.users:
        _handleUsersInitial(emitter, event);
        break;
      case SearchType.repositories:
        _handleRepositoryInitial(emitter, event);
        break;
      case SearchType.issues:
        _handleIssuesInitial(emitter, event);
        break;
      default:
        emitter(DashboardInitial(selectedSearchType: event.selectedSearchType));
        break;
    }
  }

  void _handleRepositoryInitial(
      Emitter<DashboardState> emitter, InitSearch event) {
    BlocProvider.of<RepositoryBloc>(navGK.currentContext!)
        .add(const ResetDataRepositoryEvent());

    emitter(OnSearchRepository(
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
      selectedSearchType: event.selectedSearchType,
    ));

    BlocProvider.of<RepositoryBloc>(navGK.currentContext!)
        .add(GetRepositoryEvent(
      loadType: LoadType.withIndex,
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
    ));
  }

  void _handleUsersInitial(Emitter<DashboardState> emitter, InitSearch event) {
    BlocProvider.of<UsersBloc>(navGK.currentContext!)
        .add(const ResetDataUsersEvent());

    emitter(OnSearchUsers(
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
      selectedSearchType: event.selectedSearchType,
    ));

    BlocProvider.of<UsersBloc>(navGK.currentContext!).add(GetUsersEvent(
      loadType: LoadType.withIndex,
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
    ));
  }

  void _handleIssuesInitial(Emitter<DashboardState> emitter, InitSearch event) {
    BlocProvider.of<IssuesBloc>(navGK.currentContext!)
        .add(const ResetDataIssuesEvent());

    emitter(OnSearchIssues(
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
      selectedSearchType: event.selectedSearchType,
    ));

    BlocProvider.of<IssuesBloc>(navGK.currentContext!).add(GetIssuesEvent(
      loadType: LoadType.withIndex,
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
    ));
  }

  Future<void> onSearchData(
    SearchData event,
    Emitter<DashboardState> emitter,
  ) async {
    debugPrint('OnSearchDataEvent ====== ${event.selectedSearchType}');
    debugPrint('OnSearchDataEvent ====== ${event.searchKey}');
    switch (event.selectedSearchType) {
      case SearchType.users:
        _handleSearchUsers(event);
        break;
      case SearchType.repositories:
        _handleRepository(event);
        break;
      case SearchType.issues:
        _handleSearchIssues(event);
        break;
      default:
        emitter(DashboardInitial(selectedSearchType: event.selectedSearchType));
        break;
    }
  }

  void _handleRepository(SearchData event) {
    BlocProvider.of<RepositoryBloc>(navGK.currentContext!)
        .add(GetRepositoryEvent(
      loadType: LoadType.withIndex,
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
    ));
  }

  void _handleSearchUsers(SearchData event) {
    BlocProvider.of<UsersBloc>(navGK.currentContext!).add(GetUsersEvent(
      loadType: LoadType.withIndex,
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
    ));
  }

  void _handleSearchIssues(SearchData event) {
    BlocProvider.of<IssuesBloc>(navGK.currentContext!).add(GetIssuesEvent(
      loadType: LoadType.withIndex,
      searchKey: event.searchKey,
      page: event.page,
      resultCount: event.resultCount,
    ));
  }
}
