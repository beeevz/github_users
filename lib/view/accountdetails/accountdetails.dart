import 'package:flutter/material.dart';

class AccountDetailsWidget extends StatelessWidget {
  static const routePath = "/account-details/:id";
  static const routeName = "account-details";
  static const routeAccountid = "account-id";

  const AccountDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Account Details");
  }
}
