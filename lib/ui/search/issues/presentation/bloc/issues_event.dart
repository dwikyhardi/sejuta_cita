part of 'issues_bloc.dart';

abstract class IssuesEvent extends Equatable {
  const IssuesEvent();
}

class GetIssuesEvent extends IssuesEvent {
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const GetIssuesEvent({
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

class NextIssuesEvent extends IssuesEvent {
  final RefreshController? controller;
  final Issues issues;
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const NextIssuesEvent({
    this.controller,
    required this.issues,
    required this.loadType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
        controller,
        issues,
        loadType,
        searchKey,
        page,
        resultCount,
      ];
}

class ChangeLoadTypeIssueEvent extends IssuesEvent {
  final Issues issues;
  final LoadType loadType;
  final String searchKey;
  final int page;
  final int? resultCount;

  const ChangeLoadTypeIssueEvent({
    required this.issues,
    required this.loadType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  });

  @override
  List<Object?> get props => [
        issues,
        loadType,
        searchKey,
        page,
        resultCount,
      ];
}

class ResetDataIssuesEvent extends IssuesEvent {
  const ResetDataIssuesEvent();

  @override
  List<Object?> get props => [];
}