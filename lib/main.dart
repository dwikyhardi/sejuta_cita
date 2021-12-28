import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav_router/nav_router.dart';

import 'di/injection_container.dart' as di;
import 'ui/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'ui/dashboard/presentation/pages/dashboard.dart';
import 'ui/search/issues/presentation/bloc/issues_bloc.dart';
import 'ui/search/repo/presentation/bloc/repository_bloc.dart';
import 'ui/search/users/presentation/bloc/users_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<DashboardBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<IssuesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<UsersBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<RepositoryBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navGK,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const Dashboard(),
      ),
    );
  }
}
