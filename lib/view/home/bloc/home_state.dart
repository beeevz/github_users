part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Account>? favourites;
  final List<Account>? searchedAccounts;

  const HomeState({this.favourites, this.searchedAccounts});

  @override
  List<Object?> get props => [favourites, searchedAccounts];

  HomeState addFavourite(Account account) {
    favourites?.add(account);
    return HomeState(
      favourites: favourites,
      searchedAccounts: searchedAccounts,
    );
  }

  HomeState copyWith({
    List<Account>? favourites,
    List<Account>? searchedAccounts,
  }) {
    return HomeState(
      favourites: favourites ?? this.favourites,
      searchedAccounts: searchedAccounts ?? this.searchedAccounts,
    );
  }
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {
  const HomeLoading({super.favourites});

  @override
  List<Object?> get props => [favourites];
}

final class AccountsLoaded extends HomeState {}

final class AccountsLoadFailed extends HomeState {
  final GetAccountsError error;

  const AccountsLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}

final class AccountStored extends HomeState {}
