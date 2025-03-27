part of 'accountdetails_bloc.dart';

sealed class AccountDetailsEvent extends Equatable {
  const AccountDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadAccountDetails extends AccountDetailsEvent {
  final String? account;

  const LoadAccountDetails(this.account);
}
