part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class AccountsLoaded extends HomeState {
  final List<Account> accountList;

  AccountsLoaded(this.accountList);

  @override
  List<Object> get props => [accountList];
}

final class AccountsLoadFailed extends HomeState {
  final GetAccountsError error;

  AccountsLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
