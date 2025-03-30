import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/search_storage/model/search.dart';

class InitialData {
  final List<Search> searchQuery;
  final List<Account> favourites;

  const InitialData({required this.searchQuery, required this.favourites});
}
