part of 'repository_bloc.dart';

abstract class RepositoryState extends Equatable {
  final LoadType loadType;

  const RepositoryState({required this.loadType});

  @override
  List<Object> get props => [loadType];
}

class RepositoryInitial extends RepositoryState {
  @override
  List<Object> get props => [];

  const RepositoryInitial({required LoadType loadType})
      : super(
          loadType: loadType,
        );
}

class OnRepositoryLoading extends RepositoryState {
  const OnRepositoryLoading({required LoadType loadType})
      : super(loadType: loadType);

  @override
  List<Object> get props => [loadType];
}

class OnRepositoryLoaded extends RepositoryState {
  final Repository repository;
  final String searchKey;
  final int resultCount;
  final int page;
  final bool isLoading;

  const OnRepositoryLoaded({
    required LoadType loadType,
    required this.searchKey,
    required this.repository,
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
    repository,
        resultCount,
        page,
        isLoading,
      ];
}

class OnRepositoryError extends RepositoryState {
  final String errorMessage;

  const OnRepositoryError({
    required this.errorMessage,
    required LoadType loadType,
  }) : super(loadType: loadType);

  @override
  List<Object> get props => [
        errorMessage,
        loadType,
      ];
}
