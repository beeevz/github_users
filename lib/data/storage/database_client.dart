import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'github_users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE account_storage (
            login TEXT PRIMARY KEY,
            avatar_url TEXT,
            type TEXT, 
            favourite INTEGER NULL
          );
          ''');

        await db.execute('''
          CREATE TABLE search_queries (
            query TEXT PRIMARY KEY
          )
        ''');
      },
    );
  }
}
