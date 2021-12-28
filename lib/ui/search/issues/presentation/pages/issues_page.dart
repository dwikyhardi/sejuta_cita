import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sejuta_cita/core/util/capitalize.dart';
import 'package:sejuta_cita/core/widget/number_pagination.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/issues/presentation/bloc/issues_bloc.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({
    Key? key,
  }) : super(key: key);

  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  final RefreshController _controller = RefreshController();
  final paginationKey = GlobalKey(debugLabel: 'createPagination');
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesBloc, IssuesState>(
      builder: (context, state) {
        if (state is OnIssuesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OnIssuesLoaded) {
          return issuesBody(state);
        } else if (state is OnIssuesError) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget issuesBody(OnIssuesLoaded data) {
    if (data.loadType == LoadType.lazyLoading) {
      int index = (data.page * data.resultCount) - 1;
      debugPrint('_loadTypeChooser ========== $index');
      itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
    int pageLength = (data.issues.totalCount / data.resultCount).ceil();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _loadTypeChooser(data),
        Flexible(
          child: SmartRefresher(
            controller: _controller,
            enablePullDown: false,
            enablePullUp: true,
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("release to load more");
                } else {
                  body = const Text("No more Data");
                }
                if (data.loadType == LoadType.lazyLoading) {
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            onLoading: () {
              if (data.loadType == LoadType.lazyLoading) {
                debugPrint('Page Before add =========== ${data.page}');
                var newPage = data.page + 1;
                debugPrint('Page after add =========== $newPage');
                BlocProvider.of<IssuesBloc>(context).add(NextIssuesEvent(
                  controller: _controller,
                  issues: data.issues,
                  loadType: data.loadType,
                  searchKey: data.searchKey,
                  page: newPage,
                  resultCount: data.resultCount,
                ));
              } else {
                _controller.loadComplete();
                setState(() {});
              }
            },
            child: ScrollablePositionedList.builder(
                shrinkWrap: true,
                itemScrollController: itemScrollController,
                padding: EdgeInsets.only(
                    bottom: AppBar().preferredSize.height * 0.1),
                itemCount: data.issues.items.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  var issuesData = data.issues.items[index];
                  DateTime updatedAt =
                      DateTime.parse(issuesData.updatedAt ?? '');
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(buildContext).size.width * 0.6,
                            child: Text(issuesData.title ?? '')),
                        Text(issuesData.state ?? ''),
                      ],
                    ),
                    subtitle: Text(
                      '${updatedAt.day}/${updatedAt.month}/${updatedAt.year}',
                    ),
                  );
                }),
          ),
        ),
        Offstage(
          offstage: data.loadType == LoadType.lazyLoading,
          child: _createPagination(data, pageLength),
        ),
      ],
    );
  }

  NumberPagination _createPagination(OnIssuesLoaded data, int pageLength) {
    paginationKey.currentState?.didChangeDependencies();
    return NumberPagination(
      key: paginationKey,
      listener: (newPage) {
        BlocProvider.of<IssuesBloc>(context).add(NextIssuesEvent(
          issues: data.issues,
          loadType: data.loadType,
          searchKey: data.searchKey,
          page: newPage,
          resultCount: data.resultCount,
        ));
      },
      totalPage: pageLength >= 99 ? 99 : pageLength,
      currentPage: data.page,
      threshold: 5,
    );
  }

  Widget _loadTypeChooser(OnIssuesLoaded data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _chooserLoadType(data, LoadType.lazyLoading),
        _chooserLoadType(data, LoadType.withIndex),
      ],
    );
  }

  InkWell _chooserLoadType(OnIssuesLoaded data, LoadType loadType) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        BlocProvider.of<IssuesBloc>(context).add(ChangeLoadTypeIssueEvent(
          issues: data.issues,
          loadType: loadType,
          searchKey: data.searchKey,
          page: data.page,
          resultCount: data.resultCount,
        ));
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.35,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: data.loadType == loadType
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.01),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Text(
          Capitalize()(loadType.toString().replaceAll('LoadType.', '')),
          style: TextStyle(
            color: data.loadType == loadType
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }

}
