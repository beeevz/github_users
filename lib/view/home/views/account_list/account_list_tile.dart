import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/common/localization/translation_helper.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/view/accountdetails/accountdetails.dart';
import 'package:github_users/view/home/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountListTile extends StatefulWidget {
  final Account account;

  const AccountListTile(this.account, {super.key});

  @override
  State<AccountListTile> createState() => _AccountListTileState();
}

class _AccountListTileState extends State<AccountListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AccountDetailsWidget.routeName,
          pathParameters: {
            AccountDetailsWidget.routeAccountid: widget.account.account,
          },
        );
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
                if (widget.account.isFavourite) {
                  context.read<HomeBloc>().add(
                    UnFavouriteAccount(widget.account),
                  );
                } else {
                  context.read<HomeBloc>().add(
                    FavouriteAccount(widget.account),
                  );
                }
              },
              icon: Icon(
                widget.account.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: _getFavouriteColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getFavouriteColor(BuildContext context) {
    if (widget.account.isFavourite) {
      return Theme.of(context).sliderTheme.activeTrackColor;
    } else {
      return Theme.of(context).sliderTheme.disabledActiveTrackColor;
    }
  }
}
