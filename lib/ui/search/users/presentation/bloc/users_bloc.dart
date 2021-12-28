import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';
import 'package:sejuta_cita/ui/search/issues/domain/usecases/get_issues_list.dart';
import 'package:sejuta_cita/ui/search/users/domain/entities/users.dart';
import 'package:sejuta_cita/ui/search/users/domain/usecases/get_user_list.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  GetUserList getUsersList;
  List<User>? usersData = [];
  List<User>? lastUsersData = [];

  UsersBloc({required this.getUsersList})
      : super(const UsersInitial(loadType: LoadType.withIndex)) {
    on<UsersEvent>((event, emit) {});
    on<GetUsersEvent>((event, emit) => onGetUsersEvent(event, emit));
    on<NextUsersEvent>((event, emit) => onNextUsersEvent(event, emit));
    on<ChangeLoadTypeUsersEvent>(
        (event, emit) => onChangeLoadTypeUsersEvent(event, emit));
    on<ResetDataUsersEvent>(
        (event, emit) => onResetDataUsersEvent(event, emit));
  }

  Future<void> onGetUsersEvent(
    GetUsersEvent event,
    Emitter<UsersState> emitter,
  ) async {
    emitter(OnUsersLoading(loadType: event.loadType));

    await getUsersList(
      Params(
        searchKey: event.searchKey,
        page: event.page,
        resultCount: event.resultCount,
      ),
    ).then((value) {
      value.fold(
        (l) => emitter(OnUsersError(
          errorMessage: l.errorMessage,
          loadType: event.loadType,
        )),
        (r) {
          _updateUserData(r);
          emitter(OnUsersLoaded(
            isLoading: false,
            loadType: event.loadType,
            searchKey: event.searchKey,
            users: r,
            resultCount: event.resultCount ?? 10,
            page: event.page,
          ));
        },
      );
    });
  }

  void _updateUserData(Users r) {
    lastUsersData = r.items;
    for (var element in r.items) {
      var index = usersData?.indexWhere((elementUsers) => elementUsers.id == element.id);
      if(index == -1){
        usersData?.add(element);
      }
    }
  }

  Future<void> onNextUsersEvent(
    NextUsersEvent event,
    Emitter<UsersState> emitter,
  ) async {
    if (event.loadType == LoadType.withIndex) {
      emitter(OnUsersLoading(loadType: event.loadType));
    } else {
      emitter(OnUsersLoaded(
        isLoading: true,
        loadType: event.loadType,
        searchKey: event.searchKey,
        users: event.users,
        resultCount: event.resultCount ?? 10,
        page: event.page,
      ));
    }

    await getUsersList(
      Params(
        searchKey: event.searchKey,
        page: event.page,
        resultCount: event.resultCount,
      ),
    ).then((value) {
      value.fold(
        (l) {
          if (event.loadType == LoadType.lazyLoading) {
            event.controller?.loadFailed();
          }
          emitter(OnUsersError(
            errorMessage: l.errorMessage,
            loadType: event.loadType,
          ));
        },
        (r) {
          var users = event.users;
          if (event.loadType == LoadType.lazyLoading) {
            for (var element in r.items) {
              var index = usersData?.indexWhere((elementUsers) => elementUsers.id == element.id);
              if(index == -1){
                usersData?.add(element);
              }
            }
            lastUsersData = r.items;
            if(r.items.isNotEmpty){
              event.controller?.loadComplete();
            }else{
              event.controller?.loadNoData();
            }
          } else {
            users = r;
            _updateUserData(r);
            if(r.items.isNotEmpty){
              event.controller?.loadComplete();
            }else{
              event.controller?.loadNoData();
            }
          }
          emitter(OnUsersLoaded(
            isLoading: false,
            loadType: event.loadType,
            searchKey: event.searchKey,
            users: users,
            resultCount: event.resultCount ?? 10,
            page: event.page,
          ));
        },
      );
    });
  }

  Future<void> onChangeLoadTypeUsersEvent(
    ChangeLoadTypeUsersEvent event,
    Emitter<UsersState> emitter,
  ) async {
    List<User> newUserList = [];

    if ((usersData?.isNotEmpty ?? false) &&
        (lastUsersData?.isNotEmpty ?? false)) {
      if (event.loadType == LoadType.lazyLoading) {
        newUserList = usersData ?? [];
      } else {
        newUserList = lastUsersData ?? [];
      }
    } else {
      newUserList = event.users.items;
    }

    Users newUsers = Users(
      totalCount: event.users.totalCount,
      incompleteResults: event.users.incompleteResults,
      items: newUserList,
    );

    emitter(OnUsersLoaded(
      isLoading: false,
      loadType: event.loadType,
      searchKey: event.searchKey,
      users: newUsers,
      resultCount: event.resultCount ?? 10,
      page: event.page,
    ));
  }

  Future<void> onResetDataUsersEvent(
      ResetDataUsersEvent event, Emitter<UsersState> emitter) async {
    lastUsersData = [];
    usersData = [];

    emitter(const UsersInitial(loadType: LoadType.withIndex));
  }
}
