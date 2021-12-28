import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';
import 'package:sejuta_cita/ui/search/issues/domain/usecases/get_issues_list.dart';

part 'issues_event.dart';

part 'issues_state.dart';

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  GetIssuesList getIssuesList;
  List<Items>? issuesData = [];
  List<Items>? lastIssuesData = [];

  IssuesBloc({required this.getIssuesList})
      : super(const IssuesInitial(loadType: LoadType.withIndex)) {
    on<IssuesEvent>((event, emit) {});
    on<GetIssuesEvent>((event, emit) => onGetIssuesEvent(event, emit));
    on<NextIssuesEvent>((event, emit) => onNextIssuesEvent(event, emit));
    on<ChangeLoadTypeIssueEvent>(
        (event, emit) => onChangeLoadTypeIssueEvent(event, emit));
    on<ResetDataIssuesEvent>(
        (event, emit) => onResetDataIssuesEvent(event, emit));
  }

  Future<void> onGetIssuesEvent(
    GetIssuesEvent event,
    Emitter<IssuesState> emitter,
  ) async {
    emitter(OnIssuesLoading(loadType: event.loadType));

    await getIssuesList(
      Params(
        searchKey: event.searchKey,
        page: event.page,
        resultCount: event.resultCount,
      ),
    ).then((value) {
      value.fold(
          (l) => emitter(OnIssuesError(
                errorMessage: l.errorMessage,
                loadType: event.loadType,
              )), (r) {
        lastIssuesData = r.items;
        issuesData = r.items;
        emitter(OnIssuesLoaded(
          isLoading: false,
          loadType: event.loadType,
          searchKey: event.searchKey,
          issues: r,
          resultCount: event.resultCount ?? 10,
          page: event.page,
        ));
      });
    });
  }

  Future<void> onNextIssuesEvent(
    NextIssuesEvent event,
    Emitter<IssuesState> emitter,
  ) async {
    if (event.loadType == LoadType.withIndex) {
      emitter(OnIssuesLoading(loadType: event.loadType));
    } else {
      emitter(OnIssuesLoaded(
        isLoading: true,
        loadType: event.loadType,
        searchKey: event.searchKey,
        issues: event.issues,
        resultCount: event.resultCount ?? 10,
        page: event.page,
      ));
    }

    await getIssuesList(
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
          emitter(OnIssuesError(
            errorMessage: l.errorMessage,
            loadType: event.loadType,
          ));
        },
        (r) {
          var issues = event.issues;
          if (event.loadType == LoadType.lazyLoading) {
            for (var element in r.items) {
              var index = issuesData
                  ?.indexWhere((elementUsers) => elementUsers.id == element.id);
              if (index == -1) {
                issuesData?.add(element);
              }
            }
            lastIssuesData = r.items;
            if (r.items.isNotEmpty) {
              event.controller?.loadComplete();
            } else {
              event.controller?.loadNoData();
            }
          } else {
            issues = r;
            lastIssuesData = r.items;
            for (var element in r.items) {
              var index = issuesData
                  ?.indexWhere((elementUsers) => elementUsers.id == element.id);
              if (index == -1) {
                issuesData?.add(element);
              }
            }
          }

          emitter(OnIssuesLoaded(
            isLoading: false,
            loadType: event.loadType,
            searchKey: event.searchKey,
            issues: issues,
            resultCount: event.resultCount ?? 10,
            page: event.page,
          ));
        },
      );
    });
  }

  Future<void> onChangeLoadTypeIssueEvent(
    ChangeLoadTypeIssueEvent event,
    Emitter<IssuesState> emitter,
  ) async {
    List<Items> newIssuesList = [];

    if ((issuesData?.isNotEmpty ?? false) &&
        (lastIssuesData?.isNotEmpty ?? false)) {
      if (event.loadType == LoadType.lazyLoading) {
        newIssuesList = issuesData ?? [];
      } else {
        newIssuesList = lastIssuesData ?? [];
      }
    } else {
      newIssuesList = event.issues.items;
    }

    var newIssues = Issues(
      totalCount: event.issues.totalCount,
      incompleteResults: event.issues.incompleteResults,
      items: newIssuesList,
    );

    emitter(OnIssuesLoaded(
      isLoading: false,
      loadType: event.loadType,
      searchKey: event.searchKey,
      issues: newIssues,
      resultCount: event.resultCount ?? 10,
      page: event.page,
    ));
  }

  Future<void> onResetDataIssuesEvent(
      ResetDataIssuesEvent event, Emitter<IssuesState> emitter) async {
    lastIssuesData = [];
    issuesData = [];

    emitter(const IssuesInitial(loadType: LoadType.withIndex));
  }
}
