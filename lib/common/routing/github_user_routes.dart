import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/view/accountdetails/accountdetails.dart';
import 'package:github_users/view/accountdetails/bloc/accountdetails_bloc.dart';
import 'package:github_users/view/home/bloc/home_bloc.dart';
import 'package:github_users/view/home/home_widget.dart';
import 'package:go_router/go_router.dart';

class GithubUserRoutes {
  static final githubUserRoutes = [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return HomeWidget.routePath;
      },
    ),
    GoRoute(
      path: HomeWidget.routePath,
      name: HomeWidget.routeName,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => HomeBloc(),
          child: HomeWidget(),
        );
      },
      routes: [
        GoRoute(
          path: AccountDetailsWidget.routePath,
          name: AccountDetailsWidget.routeName,
          builder: (context, state) {
            final account =
                state.pathParameters[AccountDetailsWidget.routeAccountid];
            return BlocProvider(
              create: (context) => AccountdetailsBloc(),
              child: AccountDetailsWidget(account: account),
            );
          },
        ),
      ],
    ),
  ];
}
