import 'package:github_users/data/accounts/model/account.dart';
import 'package:github_users/data/network/result.dart';
import 'package:github_users/data/repo_storage/account_storage_error.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AccountStorage {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'account_storage.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE account_storage (
            login TEXT PRIMARY KEY,
            avatar_url TEXT,
            type TEXT, 
            favourite BOOLEAN NULLABLE 
          )
        ''');
      },
    );
  }

  // Insert an Account
  Future<Result<Null, AccountStorageError>> insertAccount(
    Account account,
  ) async {
    final db = await database;
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
      final db = await database;
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
  Future<int> deleteAccount(String account) async {
    final db = await database;
    return await db.delete(
      'account_storage',
      where: 'name = ?',
      whereArgs: [account],
    );
  }
}
