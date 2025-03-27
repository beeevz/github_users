part of 'home_bloc.dart';

sealed class HomeEvent {}

class LoadAccounts extends HomeEvent {
  final String enteredValue;

  LoadAccounts(this.enteredValue);
}
