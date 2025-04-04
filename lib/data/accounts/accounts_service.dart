import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/account_error.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/accounts/model/account_details.dart';
import 'package:github_users/data/network/network_client.dart';
import 'package:github_users/data/network/result.dart';

class AccountsService {
  final networkClient = GetIt.instance<NetworkClient>();

  Future<Result<List<Account>, GetAccountsError>> getAccounts(
    String query,
  ) async {
    try {
      final path = "/search/users?q=$query";
      final response = await networkClient.get(path);
      if (response.statusCode != 200) return Error(GeneralAccountsFailed());

      List<Account> accountList = [];
      final githubResponse = json.decode(response.body) as Map<String, dynamic>;
      for (var accountProps in githubResponse['items'] as List) {
        accountList.add(Account.fromJson(accountProps));
      }
      return Success(accountList);
    } catch (e) {
      return Error(GeneralAccountsFailed());
    }
  }

  Future<Result<AccountDetails, GetAccountsError>> getAccountDetails(
    String? username,
  ) async {
    try {
      final uri = "/users/$username";
      final response = await networkClient.get(uri);
      if (response.statusCode != 200) return Error(GeneralAccountsFailed());

      final responseProps = json.decode(response.body) as Map<String, dynamic>;
      final accountDetails = AccountDetails.fromJson(responseProps);
      return Success(accountDetails);
    } catch (e) {
      return Error(GeneralAccountsFailed());
    }
  }
}
