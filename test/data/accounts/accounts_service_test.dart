import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/accounts_service.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/network/network_client.dart';
import 'package:github_users/data/network/result.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

class _MockNetworkClient extends mocktail.Mock implements NetworkClient {}

void main() {
  final mNetworkClient = _MockNetworkClient();
  GetIt.instance.registerLazySingleton<NetworkClient>(() => mNetworkClient);

  final accountsService = AccountsService();

  test('Testing getAccounts failure', () async {
    mocktail.when(() => mNetworkClient.get(mocktail.any())).thenAnswer((
      invoc,
    ) async {
      final mResponse = Response("Failed", 200);
      return Future.value(mResponse);
    });

    final result = await accountsService.getAccounts('testQuery');

    assert(result is Error);
    final error = (result as Error).error;
    expect(error, GeneralAccountsFailed());
  });
}
