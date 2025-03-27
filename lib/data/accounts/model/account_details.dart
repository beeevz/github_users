class AccountDetails {
  String? username;
  String? name;
  String? avatarUrl;
  String? bio;
  int? publicRepos;
  int? publicGists;
  int? followers;
  int? following;
  String? createdAt;

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
  });

  AccountDetails.fromJson(Map<String, dynamic> json)
    : name = json['login'] as String,
      username = json['username'] as String?,
      createdAt = json['created_at'] as String?,
      avatarUrl = json['avatar_url'] as String?,
      bio = json['bio'] as String?,
      followers = json['followers'] as int?,
      following = json['following'] as int?,
      publicRepos = json['publicRepos'] as int?,
      publicGists = json['publicGists'] as int?;
}
