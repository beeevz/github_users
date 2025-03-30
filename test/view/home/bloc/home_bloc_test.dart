import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/accounts_service.dart';
import 'package:github_users/data/network/result.dart';
import 'package:github_users/data/repo_storage/account_storage.dart';
import 'package:github_users/data/search_storage/model/search.dart';
import 'package:github_users/data/search_storage/search_storage.dart';
import 'package:github_users/view/accountdetails/domain/fetch_account_details_with_repo_list_use_case.dart';
import 'package:github_users/view/home/bloc/home_bloc.dart';
import 'package:github_users/view/home/fetch_favourites_and_search_history/fetch_favourites_and_search_history.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

class _MockAccountService extends mocktail.Mock implements AccountsService {}

class _MockAccountStorage extends mocktail.Mock implements AccountStorage {}

class _MockSearchStorage extends mocktail.Mock implements SearchStorage {}

class _MockFetchFavouritesAndSearchHistory extends mocktail.Mock
    implements FetchFavouritesAndSearchHistory {}

void main() {
  final mAccountService = _MockAccountService();
  final mAccountStorage = _MockAccountStorage();
  final mSearchStorage = _MockSearchStorage();
  final mFetchFavouritesAndSearchHistory =
      _MockFetchFavouritesAndSearchHistory();

  GetIt.instance.registerLazySingleton<AccountsService>(() => mAccountService);
  GetIt.instance.registerLazySingleton<AccountStorage>(() => mAccountStorage);
  GetIt.instance.registerLazySingleton<SearchStorage>(() => mSearchStorage);
  GetIt.instance.registerLazySingleton<FetchFavouritesAndSearchHistory>(
    () => mFetchFavouritesAndSearchHistory,
  );

  HomeBloc homeBloc = HomeBloc();

  setUpAll(() {
    mocktail.registerFallbackValue(Search("testSearch"));
  });

  blocTest(
    'Testing Load Accounts Failure',
    build: () {
      mocktail
          .when(() => mSearchStorage.insertSearch(mocktail.any()))
          .thenAnswer((invoc) async {
            // Do nothing
            return Future.value(Success(null));
          });

      mocktail
          .when(() => mAccountService.getAccounts(mocktail.any()))
          .thenAnswer((invoc) async {
            // Do nothing
            return Future.value(Error(GeneralAccountsFailed()));
          });
      return homeBloc;
    },
    act: (bloc) => bloc.add(LoadAccounts('test')),
    expect:
        () => [isA<HomeLoading>(), AccountsLoadFailed(GeneralAccountsFailed())],
  );
}
