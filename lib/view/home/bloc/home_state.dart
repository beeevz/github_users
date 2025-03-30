part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Account>? favourites;
  final List<Search>? searchHistory;
  final List<Account>? searchedAccounts;

  const HomeState({this.favourites, this.searchedAccounts, this.searchHistory});

  @override
  List<Object?> get props => [favourites, searchedAccounts, searchHistory];

  HomeState addFavourite(Account account) {
    return HomeState(
      favourites: [...?favourites, account],
      searchedAccounts: searchedAccounts,
      searchHistory: searchHistory,
    );
  }

  HomeState removeFavourite(Account account) {
    return HomeState(
      favourites: favourites?.where((a) => a != account).toList(),
      searchedAccounts: searchedAccounts,
      searchHistory: searchHistory,
    );
  }

  HomeState copyWith({
    List<Account>? favourites,
    List<Account>? searchedAccounts,
    List<Search>? searchHistory,
  }) {
    return HomeState(
      favourites: favourites ?? this.favourites,
      searchedAccounts: searchedAccounts ?? this.searchedAccounts,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {
  const HomeLoading({super.favourites, super.searchHistory});

  @override
  List<Object?> get props => [favourites, searchHistory];
}

final class AccountsLoaded extends HomeState {}

final class AccountsLoadFailed extends HomeState {
  final GetAccountsError error;

  const AccountsLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}

final class AccountStored extends HomeState {}
