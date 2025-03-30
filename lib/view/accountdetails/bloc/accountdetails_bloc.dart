import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/model/account_details.dart';
import 'package:github_users/data/network/result.dart';
import 'package:github_users/view/accountdetails/domain/fetch_account_details_with_repo_list_use_case.dart';

part 'accountdetails_event.dart';
part 'accountdetails_state.dart';

class AccountdetailsBloc
    extends Bloc<AccountDetailsEvent, AccountDetailsState> {
  // final accountService = GetIt.instance<AccountsService>();
  final _fetchAccountDetailsUseCase =
      GetIt.instance<FetchAccountDetailsWithRepoListUseCase>();

  AccountdetailsBloc() : super(AccountDetailsLoading()) {
    on<LoadAccountDetails>(_loadAccountDetails);
  }

  _loadAccountDetails(
    LoadAccountDetails event,
    Emitter<AccountDetailsState> emit,
  ) async {
    if (event.account == null) {
      emit(AccountDetailsFailed(GeneralAccountsFailed()));
    }

    final result = await _fetchAccountDetailsUseCase(event.account!);
    switch (result) {
      case Success():
        emit(AccountDetailsLoaded(accountDetails: result.data));
      case Error():
        emit(AccountDetailsFailed(result.error));
    }
  }
}
