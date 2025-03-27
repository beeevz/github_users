import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/common/globals.dart';

class GlobalsRegister {
  static register() async {
    await dotenv.load(fileName: "config/config.env");

    final getIt = GetIt.instance;
    getIt.registerLazySingleton(
      () => Globals(domain: dotenv.env['DOMAIN'] ?? "", apiKey: ""),
    );
  }
}
