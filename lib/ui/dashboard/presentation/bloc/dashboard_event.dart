part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  final SearchType? selectedSearchType;

  const DashboardEvent(this.selectedSearchType);

  @override
  List<Object?> get props => [selectedSearchType];
}

class ChangeSearchType extends DashboardEvent {
  const ChangeSearchType({SearchType? selectedSearchType}) : super(selectedSearchType);

  @override
  List<Object?> get props => [selectedSearchType];
}

class InitSearch extends DashboardEvent {
  final String searchKey;
  final int page;
  final int? resultCount;

  const InitSearch({
    SearchType? selectedSearchType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  }) : super(selectedSearchType);

  @override
  List<Object?> get props =>
      [
        selectedSearchType,
        searchKey,
        page,
        resultCount,
      ];
}

class SearchData extends DashboardEvent {
  final String searchKey;
  final int page;
  final int? resultCount;

  const SearchData({
    SearchType? selectedSearchType,
    required this.searchKey,
    required this.page,
    this.resultCount,
  }) : super(selectedSearchType);

  @override
  List<Object?> get props =>
      [
        selectedSearchType,
        searchKey,
        page,
        resultCount,
      ];
}
