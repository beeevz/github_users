import 'package:github_users/view/accountdetails/accountdetails.dart';
import 'package:github_users/view/home/home.dart';
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
        return HomeWidget();
      },
    ),
    GoRoute(
      path: AccountDetailsWidget.routePath,
      name: AccountDetailsWidget.routeName,
      builder: (context, state) {
        return AccountDetailsWidget();
      },
    ),
  ];
}
