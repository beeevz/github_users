import 'package:github_users/data/network/result.dart';

sealed class GetAccountsError extends RootError {}

class GeneralAccountsFailed extends GetAccountsError {}
