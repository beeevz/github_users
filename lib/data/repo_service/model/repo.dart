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
    : name = json['name'] as String,
      createdAt = json['created_at'] as String?,
      stargazersCount = json['stargazers_count'] as int?,
      forksCount = json['forks_count'] as int?,
      watchersCount = json['watchers_count'] as int?,
      description = json['description'] as String?,
      language = json['language'] as String?,
      htmlUrl = json['url'] as String?;
}
