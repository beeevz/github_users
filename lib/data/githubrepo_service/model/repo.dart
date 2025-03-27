class Repo {
  String name;
  String? createdAt;
  int? stargazersCount;
  int? forksCount;
  int? watchersCount;
  String? description;
  String? language;
  String? htmlUrl;

  Repo({
    required this.name,
    required this.createdAt,
    required this.stargazersCount,
    required this.forksCount,
    required this.watchersCount,
    required this.description,
    required this.language,
    required this.htmlUrl,
  });

  Repo.fromJson(Map<String, dynamic> json)
    : name = json['login'] as String,
      createdAt = json['avatar_url'] as String?,
      stargazersCount = json['type'] as int?,
      forksCount = json['type'] as int?,
      watchersCount = json['type'] as int?,
      description = json['type'] as String?,
      language = json['type'] as String?,
      htmlUrl = json['type'] as String?;
}
