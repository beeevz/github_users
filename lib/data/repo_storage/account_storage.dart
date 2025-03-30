import 'package:get_it/get_it.dart';
import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/network/result.dart';
import 'package:github_users/data/repo_storage/account_storage_error.dart';
import 'package:github_users/data/storage/database_client.dart';
import 'package:sqflite/sqflite.dart';

class AccountStorage {
  final dbClient = GetIt.instance<DatabaseClient>();
  // Insert an Account
  Future<Result<Null, AccountStorageError>> insertAccount(
    Account account,
  ) async {
    final db = await dbClient.database;
    final result = await db.insert(
      'account_storage',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (result != 0) {
      return Success(null);
    } else {
      return Error(AccountStorageError());
    }
  }

  // Retrieve all Accounts
  Future<Result<List<Account>, AccountStorageError>> getAccounts() async {
    try {
      final db = await dbClient.database;
      final List<Map<String, dynamic>> maps = await db.query('account_storage');
      final accountList = List.generate(
        maps.length,
        (i) => Account.fromJson(maps[i]),
      );
      return Success(accountList);
    } catch (e) {
      return Error(AccountStorageError());
    }
  }

  // Delete an Account
  Future<Result<Null, AccountStorageError>> deleteAccount(
    String account,
  ) async {
    final db = await dbClient.database;
    final result = await db.delete(
      'account_storage',
      where: 'login = ?',
      whereArgs: [account],
    );

    if (result != 0) {
      return Success(null);
    } else {
      return Error(AccountStorageError());
    }
  }
}
