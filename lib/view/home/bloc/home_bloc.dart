import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/common/extensions/list_nullable_ext.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/accounts_service.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/network/result.dart';
import 'package:github_users/data/repo_storage/account_storage.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _accountService = GetIt.instance<AccountsService>();
  final _accountStorage = GetIt.instance<AccountStorage>();

  HomeBloc() : super(HomeInitial()) {
    on<LoadAccounts>(_loadAccounts);
    on<LoadFavourites>(_loadFavourites);
    on<FavouriteAccount>(_favouriteAccount);
  }

  _loadAccounts(LoadAccounts event, Emitter<HomeState> emit) async {
    emit(HomeLoading(favourites: state.favourites));
    final result = await _accountService.getAccounts(event.enteredValue);

    switch (result) {
      case Success():
        emit(state.copyWith(searchedAccounts: result.data));
      case Error():
        emit(AccountsLoadFailed(result.error));
    }
  }

  _loadFavourites(LoadFavourites event, Emitter<HomeState> emit) async {
    final result = await _accountStorage.getAccounts();

    switch (result) {
      case Success():
        // If statement to change state based on whether we get response back
        // That way we can maintain center alignment only until state changes
        if (result.data.isNotNullOrEmpty) {
          emit(state.copyWith(favourites: result.data));
        }
      case Error():
      // We can decide how we want to handle this.
    }
  }

  _favouriteAccount(FavouriteAccount event, Emitter<HomeState> emit) async {
    event.account.favourite = true;
    final result = await _accountStorage.insertAccount(event.account);

    switch (result) {
      case Success():
        final updatedState = state.addFavourite(event.account);
        emit(updatedState);
      case Error():
      // We can decide how we want to handle this.
    }
  }
}
