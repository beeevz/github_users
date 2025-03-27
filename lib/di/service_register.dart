import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/accounts_service.dart';
import 'package:github_users/data/network/network_client.dart';

class ServiceRegister {
  static register() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton(() => NetworkClient());
    getIt.registerLazySingleton(() => AccountsService());
  }
}
