part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  final SearchType? selectedSearchType;

  const DashboardState(this.selectedSearchType);

  @override
  List<Object?> get props => [selectedSearchType];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object?> get props => [selectedSearchType];

  const DashboardInitial({
    SearchType? selectedSearchType,
  }) : super(selectedSearchType);
}

class OnSearchIssues extends DashboardState {
  final String searchKey;
  final int page;
  final int? resultCount;

  const OnSearchIssues({
    SearchType? selectedSearchType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  }) : super(selectedSearchType);

  @override
  List<Object?> get props => [
        selectedSearchType,
        searchKey,
        page,
        resultCount,
      ];
}

class OnSearchUsers extends DashboardState {
  final String searchKey;
  final int page;
  final int? resultCount;

  const OnSearchUsers({
    SearchType? selectedSearchType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  }) : super(selectedSearchType);

  @override
  List<Object?> get props => [
        selectedSearchType,
        searchKey,
        page,
        resultCount,
      ];
}

class OnSearchRepository extends DashboardState {
  final String searchKey;
  final int page;
  final int? resultCount;

  const OnSearchRepository({
    SearchType? selectedSearchType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  }) : super(selectedSearchType);

  @override
  List<Object?> get props => [
    selectedSearchType,
    searchKey,
    page,
    resultCount,
  ];
}
