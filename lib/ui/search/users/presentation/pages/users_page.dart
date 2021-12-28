import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sejuta_cita/core/network/launch_another_apps.dart';
import 'package:sejuta_cita/core/util/capitalize.dart';
import 'package:sejuta_cita/core/widget/number_pagination.dart';
import 'package:sejuta_cita/ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';
import 'package:sejuta_cita/ui/search/users/presentation/bloc/users_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _controller = RefreshController();
  final ItemScrollController itemScrollController = ItemScrollController();

  final paginationKey = GlobalKey(debugLabel: 'createPagination');

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
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is OnUsersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OnUsersLoaded) {
          return usersBody(state);
        } else if (state is OnUsersError) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget usersBody(OnUsersLoaded data) {
    if (data.loadType == LoadType.lazyLoading) {
      int index = (data.page * data.resultCount) - 1;
      debugPrint('_loadTypeChooser ========== $index');
      itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
    int pageLength = (data.users.totalCount / data.resultCount).ceil();
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
                BlocProvider.of<UsersBloc>(context).add(NextUsersEvent(
                  controller: _controller,
                  users: data.users,
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
                itemScrollController: itemScrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  bottom: AppBar().preferredSize.height * 0.1,
                ),
                itemCount: data.users.items.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  var usersData = data.users.items[index];
                  return ListTile(
                    onTap: () async {
                      debugPrint('Index ========== $index');
                      showDetailUser(usersData);
                    },
                    title: Text(usersData.login ?? ''),
                    leading: CachedNetworkImage(
                      imageUrl: usersData.avatarUrl ?? '',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
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

  void showDetailUser(User usersData) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext buildContext) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              usersData.login ?? '',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: usersData.avatarUrl ?? '',
                height: MediaQuery.of(buildContext).size.width * 0.4,
                width: MediaQuery.of(buildContext).size.width * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'User Type: ${usersData.type}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'GitHub Link: ',
                children: [
                  TextSpan(
                    text: 'Link',
                    recognizer: TapGestureRecognizer()..onTap = () {
                      LaunchAnotherApp()(usersData.htmlUrl);
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  NumberPagination _createPagination(OnUsersLoaded data, int pageLength) {
    paginationKey.currentState?.didChangeDependencies();
    return NumberPagination(
      key: paginationKey,
      listener: (newPage) {
        BlocProvider.of<UsersBloc>(context).add(NextUsersEvent(
          users: data.users,
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

  Widget _loadTypeChooser(OnUsersLoaded data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _chooserLoadType(data, LoadType.lazyLoading),
        _chooserLoadType(data, LoadType.withIndex),
      ],
    );
  }

  InkWell _chooserLoadType(OnUsersLoaded data, LoadType loadType) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        BlocProvider.of<UsersBloc>(context).add(ChangeLoadTypeUsersEvent(
          users: data.users,
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
