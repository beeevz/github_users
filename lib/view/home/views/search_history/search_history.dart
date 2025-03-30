import 'package:flutter/material.dart';
import 'package:github_users/data/search_storage/model/search.dart';

class SearchHistoryWidget extends StatelessWidget {
  final List<Search> searchHistory;
  final Function(String value) callback;

  const SearchHistoryWidget({
    super.key,
    required this.searchHistory,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: List.generate(searchHistory.length, (index) {
          return InkWell(
            onTap: () {
              callback(searchHistory[index].query);
            },
            child: ListTile(title: Text(searchHistory[index].query)),
          );
        }),
      ),
    );
  }
}
