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
      type = json['type'] as String?,
      favourite = (json['favourite'] == 1);

  @override
  bool operator ==(Object other) =>
      other is Account && other.account == account;

  bool get isFavourite {
    return (favourite == true);
  }

  Map<String, Object?> toMap() {
    return {
      'login': account,
      'avatar_url': avatarUrl,
      'type': type,
      'favourite': favourite,
    };
  }

  @override
  int get hashCode => account.hashCode;
}
