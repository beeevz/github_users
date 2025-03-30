import 'package:github_users/data/network/result.dart';

sealed class ReposServiceError extends RootError {}

class GeneralFetchReposError extends ReposServiceError {}
