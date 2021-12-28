part of 'repository_bloc.dart';

abstract class RepositoryEvent extends Equatable {
  const RepositoryEvent();
}

class GetRepositoryEvent extends RepositoryEvent {
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const GetRepositoryEvent({
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

class NextRepositoryEvent extends RepositoryEvent {
  final RefreshController? controller;
  final Repository repository;
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const NextRepositoryEvent({
    this.controller,
    required this.repository,
    required this.loadType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
    controller,
    repository,
    loadType,
    searchKey,
    page,
    resultCount,
  ];
}

class ChangeLoadTypeRepositoryEvent extends RepositoryEvent {
  final Repository repository;
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const ChangeLoadTypeRepositoryEvent({
    required this.repository,
    required this.loadType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
    repository,
    loadType,
    searchKey,
    page,
    resultCount,
  ];
}

class ResetDataRepositoryEvent extends RepositoryEvent {
  const ResetDataRepositoryEvent();

  @override
  List<Object?> get props => [];
}