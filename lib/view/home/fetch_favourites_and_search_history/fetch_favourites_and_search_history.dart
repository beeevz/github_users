import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/accounts/model/account_details.dart';
import 'package:github_users/data/network/result.dart';
import 'package:github_users/data/repo_storage/account_storage.dart';
import 'package:github_users/data/search_storage/search_storage.dart';
import 'package:github_users/view/home/fetch_favourites_and_search_history/fetch_initial_data_error.dart';
import 'package:github_users/view/home/fetch_favourites_and_search_history/model/initial_data.dart';

class FetchFavouritesAndSearchHistory {
  final _accountStorage = GetIt.instance<AccountStorage>();
  final _searchStorage = GetIt.instance<SearchStorage>();

  Future<Result<InitialData, FetchInitialDataError>> call() async {
    final favouriteAccResult = await _accountStorage.getAccounts();

    switch (favouriteAccResult) {
      case Success():
        return await _getSearchHistory(favouriteAccResult.data);
      case Error():
        return Error(FetchInitialDataError());
    }
  }

  Future<Result<InitialData, FetchInitialDataError>> _getSearchHistory(
    List<Account> favourites,
  ) async {
    final searchHistoryResult = await _searchStorage.getSearchQueries();

    switch (searchHistoryResult) {
      case Success():
        return Success(
          InitialData(
            searchQuery: searchHistoryResult.data.reversed.toList(),
            favourites: favourites,
          ),
        );
      case Error():
        return Error(FetchInitialDataError());
    }
  }
}
