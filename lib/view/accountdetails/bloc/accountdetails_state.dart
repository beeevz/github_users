part of 'accountdetails_bloc.dart';

sealed class AccountDetailsState extends Equatable {
  const AccountDetailsState();

  @override
  List<Object> get props => [];
}

final class AccountDetailsLoading extends AccountDetailsState {}

final class AccountDetailsLoaded extends AccountDetailsState {
  final AccountDetails accountDetails;
  const AccountDetailsLoaded(this.accountDetails);

  @override
  List<Object> get props => [accountDetails];
}

final class AccountDetailsFailed extends AccountDetailsState {
  final GetAccountsError error;

  const AccountDetailsFailed(this.error);

  @override
  List<Object> get props => [error];
}
