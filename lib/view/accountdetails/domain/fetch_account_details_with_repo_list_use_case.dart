import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/accounts_service.dart';
import 'package:github_users/data/repo_service/repos_service.dart';
import '../../../data/accounts/model/account_details.dart';
import '../../../data/network/result.dart';

class FetchAccountDetailsWithRepoListUseCase {
  final _accountService = GetIt.instance<AccountsService>();
  final _repoService = GetIt.instance<ReposService>();

  Future<Result<AccountDetails, GetAccountsError>> call(String username) async {
    final accountDetailsRes = await _accountService.getAccountDetails(username);

    switch (accountDetailsRes) {
      case Success():
        return await _packageAccDetailsAndRepos(accountDetailsRes.data);
      case Error():
        return Error(GeneralAccountsFailed());
    }
  }

  Future<Result<AccountDetails, GetAccountsError>> _packageAccDetailsAndRepos(
    AccountDetails accDetails,
  ) async {
    if (accDetails.username == null) return Error(GeneralAccountsFailed());
    final repoListRes = await _repoService.getRepos(accDetails.username!);

    switch (repoListRes) {
      case Success():
        accDetails.repoList = repoListRes.data;
        return Success(accDetails);
      case Error():
        return Error(GeneralAccountsFailed());
    }
  }
}
