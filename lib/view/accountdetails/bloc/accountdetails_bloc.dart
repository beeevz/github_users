import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/accounts_service.dart';
import 'package:github_users/data/accounts/model/account_details.dart';
import 'package:github_users/data/network/result.dart';

part 'accountdetails_event.dart';
part 'accountdetails_state.dart';

class AccountdetailsBloc
    extends Bloc<AccountDetailsEvent, AccountDetailsState> {
  final accountService = GetIt.instance<AccountsService>();

  AccountdetailsBloc() : super(AccountDetailsLoading()) {
    on<LoadAccountDetails>(_loadAccountDetails);
  }

  _loadAccountDetails(
    LoadAccountDetails event,
    Emitter<AccountDetailsState> emit,
  ) async {
    final result = await accountService.getAccountDetails(event.account);
    switch (result) {
      case Success():
        emit(AccountDetailsLoaded(result.data));
      case Error():
        emit(AccountDetailsFailed(result.error));
    }
  }
}
