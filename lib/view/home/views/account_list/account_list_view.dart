import 'package:flutter/material.dart';
import 'package:github_users/common/extensions/list_nonnull_ext.dart';
import 'package:github_users/common/extensions/list_nullable_ext.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/view/home/views/account_list/account_list_tile.dart';

class AccountListView extends StatelessWidget {
  final List<Account> accountsForDisplay = [];

  AccountListView({
    super.key,
    List<Account>? favourites,
    List<Account>? searchedAccounts,
  }) {
    _buildSearchedList(favourites, searchedAccounts);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: List.generate(accountsForDisplay.length, (index) {
          return AccountListTile(accountsForDisplay[index]);
        }),
      ),
    );
  }

  _buildSearchedList(
    List<Account>? favourites,
    List<Account>? searchedAccounts,
  ) {
    if (!searchedAccounts.isNotNullOrEmpty) {
      accountsForDisplay.addAll(favourites ?? []);
    }
    for (Account account in searchedAccounts ?? []) {
      if (favourites?.contains(account) ?? false) {
        Account? acc = favourites?.get(account);
        if (acc != null) accountsForDisplay.add(acc);
      } else {
        accountsForDisplay.add(account);
      }
    }
  }
}
