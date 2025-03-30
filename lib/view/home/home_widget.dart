import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/common/extensions/list_nullable_ext.dart';
import 'package:github_users/common/localization/translation_helper.dart';
import 'package:github_users/view/home/bloc/home_bloc.dart';
import 'package:github_users/view/home/views/account_list/account_list_view.dart';
import 'package:github_users/view/home/views/search_history/search_history.dart';

class HomeWidget extends StatefulWidget {
  static const routePath = "/home";
  static const routeName = "home";

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late TextEditingController _searchEditingController;
  Timer? _searchDebouncer;

  @override
  void initState() {
    context.read<HomeBloc>().add(LoadInitialScreen());
    _searchEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchDebouncer?.cancel();
    _searchEditingController.dispose();
    super.dispose();
  }

  _onSearchChanged(BuildContext context, String query) {
    if (_searchDebouncer?.isActive ?? false) _searchDebouncer?.cancel();
    _searchDebouncer = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        context.read<HomeBloc>().add(LoadInitialScreen());
      } else {
        context.read<HomeBloc>().add(LoadAccounts(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
                margin: EdgeInsets.only(
                  top:
                      _alignWithTop(state)
                          ? 20
                          : MediaQuery.of(context).size.height * 0.4,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _searchEditingController,
                  decoration: InputDecoration(
                    hintText: t(context).search,
                    suffixIcon:
                        (state is HomeLoading)
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : null,
                  ),
                  onChanged: (value) {
                    _onSearchChanged(context, value);
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (state is! HomeLoading &&
                        (state.favourites.isNotNullOrEmpty ||
                            state.searchedAccounts.isNotNullOrEmpty))
                      AccountListView(
                        favourites: state.favourites ?? [],
                        searchedAccounts: state.searchedAccounts ?? [],
                      ),
                    if (state is! HomeLoading &&
                        (state.searchHistory.isNotNullOrEmpty))
                      SearchHistoryWidget(
                        searchHistory: state.searchHistory ?? [],
                        callback: (historyEntry) {
                          _searchEditingController.text = historyEntry;
                          context.read<HomeBloc>().add(
                            LoadAccounts(historyEntry),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _alignWithTop(HomeState state) {
    return (state is! HomeInitial ||
        state.favourites.isNotNullOrEmpty ||
        state.searchedAccounts.isNotNullOrEmpty);
  }
}
