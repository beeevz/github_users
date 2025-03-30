import 'package:flutter/material.dart';
import 'package:github_users/common/localization/translation_helper.dart';
import 'package:github_users/data/repo_service/model/repo.dart';

class RepoListView extends StatelessWidget {
  final List<Repo>? repoList;

  const RepoListView({super.key, required this.repoList});

  @override
  Widget build(BuildContext context) {
    if (repoList != null) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: repoList!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Column(
                  children: [
                    Text(repoList![index].name),
                    Text(repoList![index].description ?? ""),
                    Text(
                      t(
                        context,
                      ).forksCount(repoList![index].forksCount.toString()),
                    ),
                    Text(
                      t(context).stargazersCount(
                        repoList![index].stargazersCount.toString(),
                      ),
                    ),
                    Text(
                      t(context).watchersCount(
                        repoList![index].watchersCount.toString(),
                      ),
                    ),
                    Text(repoList![index].createdAt.toString()),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.7,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Center(child: Text(t(context).failed));
    }
  }
}
