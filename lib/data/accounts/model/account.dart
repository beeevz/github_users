class Account {
  String account;
  String? avatarUrl;
  String? type;
  bool? favourite;

  Account({
    required this.account,
    required this.avatarUrl,
    required this.type,
    required this.favourite,
  });

  Account.fromJson(Map<String, dynamic> json)
    : account = json['login'] as String,
      avatarUrl = json['avatar_url'] as String?,
      type = json['type'] as String?;
}
