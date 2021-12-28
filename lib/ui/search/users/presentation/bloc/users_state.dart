part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  final LoadType loadType;

  const UsersState({required this.loadType});

  @override
  List<Object> get props => [loadType];
}

class UsersInitial extends UsersState {
  @override
  List<Object> get props => [];

  const UsersInitial({required LoadType loadType})
      : super(
          loadType: loadType,
        );
}

class OnUsersLoading extends UsersState {
  const OnUsersLoading({required LoadType loadType})
      : super(loadType: loadType);

  @override
  List<Object> get props => [loadType];
}

class OnUsersLoaded extends UsersState {
  final Users users;
  final String searchKey;
  final int resultCount;
  final int page;
  final bool isLoading;

  const OnUsersLoaded({
    required LoadType loadType,
    required this.searchKey,
    required this.users,
    required this.resultCount,
    required this.page,
    required this.isLoading,
  }) : super(
          loadType: loadType,
        );

  @override
  List<Object> get props => [
        loadType,
        searchKey,
        users,
        resultCount,
        page,
        isLoading,
      ];
}

class OnUsersError extends UsersState {
  final String errorMessage;

  const OnUsersError({
    required this.errorMessage,
    required LoadType loadType,
  }) : super(loadType: loadType);

  @override
  List<Object> get props => [
        errorMessage,
        loadType,
      ];
}
