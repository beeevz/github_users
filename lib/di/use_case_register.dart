import 'package:get_it/get_it.dart';
import 'package:github_users/view/accountdetails/domain/fetch_account_details_with_repo_list_use_case.dart';

class UseCaseRegister {
  static register() {
    final getIt = GetIt.instance;

    getIt.registerFactory(() => FetchAccountDetailsWithRepoListUseCase());
  }
}
