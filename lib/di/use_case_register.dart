import 'package:get_it/get_it.dart';
import 'package:github_users/view/accountdetails/domain/fetch_account_details_with_repo_list_use_case.dart';
import 'package:github_users/view/home/fetch_favourites_and_search_history/fetch_favourites_and_search_history.dart';

class UseCaseRegister {
  static register() {
    final getIt = GetIt.instance;

    getIt.registerFactory(() => FetchAccountDetailsWithRepoListUseCase());
    getIt.registerFactory(() => FetchFavouritesAndSearchHistory());
  }
}
