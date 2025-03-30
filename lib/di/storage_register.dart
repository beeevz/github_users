import 'package:get_it/get_it.dart';
import 'package:github_users/data/repo_storage/account_storage.dart';
import 'package:github_users/data/search_storage/search_storage.dart';
import 'package:github_users/data/storage/database_client.dart';

class StorageRegister {
  static register() {
    final getIt = GetIt.instance;

    // First register Database since other dependencies require it
    getIt.registerLazySingleton(() => DatabaseClient());

    // Then continue with services
    getIt.registerLazySingleton(() => AccountStorage());
    getIt.registerLazySingleton(() => SearchStorage());
  }
}
