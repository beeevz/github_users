import 'package:github_users/data/network/result.dart';

sealed class FetchGithubreposError extends RootError {}

class GeneralFetchReposError extends FetchGithubreposError {}
