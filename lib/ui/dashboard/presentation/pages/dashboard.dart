import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita/core/util/capitalize.dart';
import 'package:sejuta_cita/ui/search/issues/presentation/pages/issues_page.dart';
import 'package:sejuta_cita/ui/search/repo/presentation/pages/repository_page.dart';
import 'package:sejuta_cita/ui/search/users/presentation/pages/users_page.dart';

import '../bloc/dashboard_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Git Utility'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _searchBox(state),
                _buildChooserSearchType(context, state),
                if (state is OnSearchIssues)
                  const Flexible(
                    child: IssuePage(),
                    flex: 15,
                  ),
                if (state is OnSearchUsers)
                  const Flexible(
                    child: UsersPage(),
                    flex: 15,
                  ),
                if (state is OnSearchRepository)
                  const Flexible(
                    child: RepositoryPage(),
                    flex: 15,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChooserSearchType(BuildContext context, DashboardState state) {
    return Flexible(
      child: Row(
        children: [
          _chooserSearchType(
            state,
            context,
            SearchType.users,
          ),
          _chooserSearchType(
            state,
            context,
            SearchType.repositories,
          ),
          _chooserSearchType(
            state,
            context,
            SearchType.issues,
          ),
        ],
      ),
    );
  }

  Widget _chooserSearchType(
    DashboardState state,
    BuildContext context,
    SearchType searchType,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / SearchType.values.length,
      child: RadioListTile<SearchType?>(
        value: searchType,
        contentPadding: EdgeInsets.zero,
        groupValue: state.selectedSearchType,
        title: Text(
          Capitalize()(
            searchType.toString().replaceAll('SearchType.', ''),
          ),
          style: const TextStyle(fontSize: 12),
        ),
        onChanged: (value) {
          BlocProvider.of<DashboardBloc>(context).add(ChangeSearchType(
            selectedSearchType: value,
          ));
        },
      ),
    );
  }

  Padding _searchBox(DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextField(
        expands: false,
        minLines: 1,
        maxLines: 1,
        scrollPadding: EdgeInsets.zero,
        textInputAction: TextInputAction.search,
        controller: searchController,
        style: Theme.of(context).textTheme.bodyText1,
        // onChanged: (value) {
        //   if (value.length > 3) {
        //     debugPrint('Length Value TextField ====== ${value.length}');
        //     debugPrint('Value TextField ====== $value');
        //     if (state is DashboardInitial) {
        //       BlocProvider.of<DashboardBloc>(context).add(InitSearch(
        //         selectedSearchType: state.selectedSearchType,
        //         searchKey: value,
        //         page: 1,
        //         resultCount: 10,
        //       ));
        //     } else {
        //       BlocProvider.of<DashboardBloc>(context).add(SearchData(
        //         selectedSearchType: state.selectedSearchType,
        //         searchKey: value,
        //         page: 1,
        //         resultCount: 10,
        //       ));
        //     }
        //   }
        // },
        onSubmitted: (value) {
          if (value.length > 3) {
            debugPrint('Length Value TextField ====== ${value.length}');
            debugPrint('Value TextField ====== $value');
            if (state is DashboardInitial) {
              BlocProvider.of<DashboardBloc>(context).add(InitSearch(
                selectedSearchType: state.selectedSearchType,
                searchKey: value,
                page: 1,
                resultCount: 10,
              ));
            } else {
              BlocProvider.of<DashboardBloc>(context).add(SearchData(
                selectedSearchType: state.selectedSearchType,
                searchKey: value,
                page: 1,
                resultCount: 10,
              ));
            }
          }
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Theme.of(context)
                      .inputDecorationTheme
                      .border
                      ?.borderSide
                      .color ??
                  Colors.white,
            ),
            gapPadding: 10,
          ),
        ),
      ),
    );
  }
}
