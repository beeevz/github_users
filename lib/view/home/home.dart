import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/common/localization/translation_helper.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/view/home/bloc/home_bloc.dart';
import 'package:github_users/view/home/views/account_list_view.dart';

class HomeWidget extends StatefulWidget {
  static const routePath = "/home";
  static const routeName = "home";

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _searchFieldController = TextEditingController();
  final _searchFocusNode = FocusNode();
  Timer? _searchDebouncer;

  @override
  void dispose() {
    _searchFieldController.dispose();
    _searchFocusNode.dispose();
    _searchDebouncer?.cancel();
    super.dispose();
  }

  _onSearchChanged(BuildContext context, String query) {
    if (query.isEmpty) return;
    if (_searchDebouncer?.isActive ?? false) _searchDebouncer?.cancel();
    _searchDebouncer = Timer(const Duration(milliseconds: 500), () {
      context.read<HomeBloc>().add(LoadAccounts(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment:
                  (state is HomeInitial)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _searchFieldController,
                  decoration: InputDecoration(
                    hintText: t(context).search,
                    suffixIcon:
                        (state is HomeLoading)
                            ? CircularProgressIndicator()
                            : null,
                  ),
                  onChanged: (value) {
                    _onSearchChanged(context, value);
                  },
                ),
                SizedBox(height: 10),
                if (state is! HomeInitial)
                  Expanded(
                    child: AccountListView(
                      accountList: _getAccountsFromState(state),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Account> _getAccountsFromState(HomeState state) {
    return (state is AccountsLoaded) ? state.accountList : [];
  }
}
