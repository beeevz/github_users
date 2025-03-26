import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/accounts_service.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/network/result.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final accountService = GetIt.instance<AccountsService>();

  HomeBloc() : super(HomeInitial()) {
    on<LoadAccounts>(_loadAccounts);
  }

  _loadAccounts(LoadAccounts event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await accountService.getAccounts(event.enteredValue);

    switch (result) {
      case Success():
        emit(AccountsLoaded(result.data));
      case Error():
        emit(AccountsLoadFailed(result.error));
    }
  }
}
