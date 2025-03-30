class Search {
  final String query;

  const Search(this.query);

  Map<String, Object?> toMap() {
    return {'query': query};
  }

  Search.fromMap(Map<String, dynamic> json) : query = json['query'] as String;
}
