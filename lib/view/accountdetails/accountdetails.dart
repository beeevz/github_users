import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/common/localization/translation_helper.dart';
import 'package:github_users/view/accountdetails/bloc/accountdetails_bloc.dart';
import 'package:github_users/view/accountdetails/views/header.dart';

class AccountDetailsWidget extends StatefulWidget {
  static const routePath = "/account-details/:id";
  static const routeName = "account-details";
  static const routeAccountid = "id";

  final String? account;

  const AccountDetailsWidget({super.key, required this.account});

  @override
  State<AccountDetailsWidget> createState() => _AccountDetailsWidgetState();
}

class _AccountDetailsWidgetState extends State<AccountDetailsWidget> {
  @override
  void initState() {
    context.read<AccountdetailsBloc>().add(LoadAccountDetails(widget.account));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AccountdetailsBloc, AccountDetailsState>(
        builder: (context, state) {
          if (state is AccountDetailsLoaded) {
            return Column(
              children: [
                HeaderWidget(avatarUrl: state.accountDetails.avatarUrl),
              ],
            );
          } else if (state is AccountDetailsLoading) {
            return CircularProgressIndicator();
          } else {
            return Center(child: Text(t(context).failed));
          }
        },
      ),
    );
  }
}
