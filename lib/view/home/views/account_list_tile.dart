import 'package:flutter/material.dart';
import 'package:github_users/common/localization/translation_helper.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/view/accountdetails/accountdetails.dart';
import 'package:github_users/view/theme/github_theme.dart';
import 'package:go_router/go_router.dart';

class AccountListTile extends StatefulWidget {
  final Account account;

  const AccountListTile(this.account, {super.key});

  @override
  State<AccountListTile> createState() => _AccountListTileState();
}

class _AccountListTileState extends State<AccountListTile> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AccountDetailsWidget.routePath);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                widget.account.avatarUrl ?? "",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.account.account),
                Text(widget.account.type ?? t(context).unknownType),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  isFavourite = !isFavourite;
                });
              },
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: _getFavouriteColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getFavouriteColor(BuildContext context) {
    // if (widget.account.favourite ?? false) {
    if (isFavourite) {
      return Theme.of(context).sliderTheme.activeTrackColor;
    } else {
      return Theme.of(context).sliderTheme.disabledActiveTrackColor;
    }
  }
}
