import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:github_users/data/githubrepo_service/fetch_githubrepos_error.dart';
import 'package:github_users/data/githubrepo_service/model/repo.dart';
import 'package:github_users/data/network/network_client.dart';
import 'package:github_users/data/network/result.dart';

class ReposService {
  final networkClient = GetIt.instance<NetworkClient>();

  Future<Result<List<Repo>, FetchGithubreposError>> getRepos(
    String username,
  ) async {
    final path = "/users/$username/repos";
    final response = await networkClient.get(path);
    if (response.statusCode != 200) return Error(GeneralFetchReposError());

    try {
      List<Repo> reposList = [];
      final responseMap = json.decode(response.body) as List;
      for (var repoProps in responseMap) {
        reposList.add(Repo.fromJson(repoProps));
      }
      return Success(reposList);
    } catch (e) {
      return Error(GeneralFetchReposError());
    }
  }
}
