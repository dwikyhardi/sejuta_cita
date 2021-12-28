import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/issues/domain/usecases/get_issues_list.dart';
import 'package:sejuta_cita/ui/search/repo/domain/entities/repository.dart';
import 'package:sejuta_cita/ui/search/repo/domain/usecases/get_repository.dart';

part 'repository_event.dart';

part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final GetRepository getRepositoryList;
  List<RepositoryItems>? repositoryData = [];
  List<RepositoryItems>? lastRepositoryData = [];

  RepositoryBloc({
    required this.getRepositoryList,
  }) : super(const RepositoryInitial(
          loadType: LoadType.withIndex,
        )) {
    on<RepositoryEvent>((event, emit) {});
    on<GetRepositoryEvent>((event, emit) => onGetRepositoryEvent(event, emit));
    on<NextRepositoryEvent>(
        (event, emit) => onNextRepositoryEvent(event, emit));
    on<ChangeLoadTypeRepositoryEvent>(
        (event, emit) => onChangeLoadTypeRepositoryEvent(event, emit));
    on<ResetDataRepositoryEvent>(
        (event, emit) => onResetDataRepositoryEvent(event, emit));
  }

  Future<void> onGetRepositoryEvent(
    GetRepositoryEvent event,
    Emitter<RepositoryState> emitter,
  ) async {
    emitter(OnRepositoryLoading(loadType: event.loadType));

    await getRepositoryList(
      Params(
        searchKey: event.searchKey,
        page: event.page,
        resultCount: event.resultCount,
      ),
    ).then((value) {
      value.fold(
        (l) => emitter(OnRepositoryError(
          errorMessage: l.errorMessage,
          loadType: event.loadType,
        )),
        (r) {
          lastRepositoryData = r.items;
          for (var element in r.items) {
            var index = repositoryData
                ?.indexWhere((elementUsers) => elementUsers.id == element.id);
            if (index == -1) {
              repositoryData?.add(element);
            }
          }
          emitter(OnRepositoryLoaded(
            isLoading: false,
            loadType: event.loadType,
            searchKey: event.searchKey,
            repository: r,
            resultCount: event.resultCount ?? 10,
            page: event.page,
          ));
        },
      );
    });
  }

  Future<void> onNextRepositoryEvent(
    NextRepositoryEvent event,
    Emitter<RepositoryState> emitter,
  ) async {
    if (event.loadType == LoadType.withIndex) {
      emitter(OnRepositoryLoading(loadType: event.loadType));
    } else {
      emitter(OnRepositoryLoaded(
        isLoading: true,
        loadType: event.loadType,
        searchKey: event.searchKey,
        repository: event.repository,
        resultCount: event.resultCount ?? 10,
        page: event.page,
      ));
    }

    await getRepositoryList(
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
          emitter(OnRepositoryError(
            errorMessage: l.errorMessage,
            loadType: event.loadType,
          ));
        },
        (r) {
          var repository = event.repository;
          if (event.loadType == LoadType.lazyLoading) {
            for (var element in r.items) {
              var index = repositoryData
                  ?.indexWhere((elementUsers) => elementUsers.id == element.id);
              if (index == -1) {
                repositoryData?.add(element);
              }
            }
            lastRepositoryData = r.items;
            if (r.items.isNotEmpty) {
              event.controller?.loadComplete();
            } else {
              event.controller?.loadNoData();
            }
          } else {
            repository = r;
            lastRepositoryData = r.items;
            for (var element in r.items) {
              var index = repositoryData
                  ?.indexWhere((elementUsers) => elementUsers.id == element.id);
              if (index == -1) {
                repositoryData?.add(element);
              }
            }
            if (r.items.isNotEmpty) {
              event.controller?.loadComplete();
            } else {
              event.controller?.loadNoData();
            }
          }
          emitter(OnRepositoryLoaded(
            isLoading: false,
            loadType: event.loadType,
            searchKey: event.searchKey,
            repository: repository,
            resultCount: event.resultCount ?? 10,
            page: event.page,
          ));
        },
      );
    });
  }

  Future<void> onChangeLoadTypeRepositoryEvent(
    ChangeLoadTypeRepositoryEvent event,
    Emitter<RepositoryState> emitter,
  ) async {
    List<RepositoryItems> newRepositoryList = [];

    if ((repositoryData?.isNotEmpty ?? false) &&
        (lastRepositoryData?.isNotEmpty ?? false)) {
      if (event.loadType == LoadType.lazyLoading) {
        newRepositoryList = repositoryData ?? [];
      } else {
        newRepositoryList = lastRepositoryData ?? [];
      }
    } else {
      newRepositoryList = event.repository.items;
    }

    Repository newRepository = Repository(
      totalCount: event.repository.totalCount,
      incompleteResults: event.repository.incompleteResults,
      items: newRepositoryList,
    );

    emitter(OnRepositoryLoaded(
      isLoading: false,
      loadType: event.loadType,
      searchKey: event.searchKey,
      repository: newRepository,
      resultCount: event.resultCount ?? 10,
      page: event.page,
    ));
  }

  Future<void> onResetDataRepositoryEvent(
      ResetDataRepositoryEvent event, Emitter<RepositoryState> emitter) async {
    lastRepositoryData = [];
    repositoryData = [];

    emitter(const RepositoryInitial(loadType: LoadType.withIndex));
  }
}
