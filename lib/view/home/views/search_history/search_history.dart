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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: searchHistory.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            callback(searchHistory[index].query);
          },
          child: Container(
            // padding: EdgeInsets.only(top: 10, bottom: 10),
            child: ListTile(title: Text(searchHistory[index].query)),
          ),
        );
      },
    );
  }
}
