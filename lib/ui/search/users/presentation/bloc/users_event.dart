part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class GetUsersEvent extends UsersEvent {
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const GetUsersEvent({
    required this.loadType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
        loadType,
        searchKey,
        page,
        resultCount,
      ];
}

class NextUsersEvent extends UsersEvent {
  final RefreshController? controller;
  final Users users;
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const NextUsersEvent({
    this.controller,
    required this.users,
    required this.loadType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
        controller,
        users,
        loadType,
        searchKey,
        page,
        resultCount,
      ];
}

class ChangeLoadTypeUsersEvent extends UsersEvent {
  final Users users;
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const ChangeLoadTypeUsersEvent({
    required this.users,
    required this.loadType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
        users,
        loadType,
        searchKey,
        page,
        resultCount,
      ];
}

class ResetDataUsersEvent extends UsersEvent {
  const ResetDataUsersEvent();

  @override
  List<Object?> get props => [];
}
