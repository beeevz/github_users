import 'package:github_users/data/githubrepo_service/model/repo.dart';

class AccountDetails {
  final String? username;
  final String? name;
  final String? avatarUrl;
  final String? bio;
  final int? publicRepos;
  final int? publicGists;
  final int? followers;
  final int? following;
  final String? createdAt;
  List<Repo>? repoList;

  AccountDetails({
    required this.username,
    required this.name,
    required this.createdAt,
    required this.avatarUrl,
    required this.bio,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    this.repoList,
  });

  AccountDetails.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      username = json['login'] as String?,
      createdAt = json['created_at'] as String?,
      avatarUrl = json['avatar_url'] as String?,
      bio = json['bio'] as String?,
      followers = json['followers'] as int?,
      following = json['following'] as int?,
      publicRepos = json['publicRepos'] as int?,
      publicGists = json['publicGists'] as int?;
}
