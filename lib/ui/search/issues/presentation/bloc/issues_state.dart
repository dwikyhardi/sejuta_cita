part of 'issues_bloc.dart';

abstract class IssuesState extends Equatable {
  final LoadType loadType;

  const IssuesState({required this.loadType});

  @override
  List<Object> get props => [loadType];
}

class IssuesInitial extends IssuesState {
  @override
  List<Object> get props => [];

  const IssuesInitial({required LoadType loadType}) : super(loadType: loadType);
}

class OnIssuesLoading extends IssuesState {
  const OnIssuesLoading({required LoadType loadType})
      : super(loadType: loadType);

  @override
  List<Object> get props => [loadType];
}

class OnIssuesLoaded extends IssuesState {
  final Issues issues;
  final String searchKey;
  final int resultCount;
  final int page;
  final bool isLoading;

  const OnIssuesLoaded({
    required LoadType loadType,
    required this.searchKey,
    required this.issues,
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
        issues,
        resultCount,
        page,
        isLoading,
      ];
}

class OnIssuesError extends IssuesState {
  final String errorMessage;

  const OnIssuesError({
    required this.errorMessage,
    required LoadType loadType,
  }) : super(loadType: loadType);

  @override
  List<Object> get props => [
        errorMessage,
        loadType,
      ];
}
