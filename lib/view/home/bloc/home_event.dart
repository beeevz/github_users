part of 'home_bloc.dart';

sealed class HomeEvent {}

class LoadAccounts extends HomeEvent {
  final String enteredValue;

  LoadAccounts(this.enteredValue);
}

class FavouriteAccount extends HomeEvent {
  final Account account;

  FavouriteAccount(this.account);
}

class LoadInitialScreen extends HomeEvent {}
