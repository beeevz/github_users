import 'package:flutter/material.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/view/home/views/account_list_tile.dart';

class AccountListView extends StatelessWidget {
  final List<Account> accountList;

  const AccountListView({super.key, required this.accountList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accountList.length,
      itemBuilder: (context, index) {
        return AccountListTile(accountList[index]);
      },
    );
  }
}
