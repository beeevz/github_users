import 'package:get_it/get_it.dart';
import 'package:github_users/data/repo_storage/account_storage.dart';

class StorageRegister {
  static register() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton(() => AccountStorage());
  }
}
