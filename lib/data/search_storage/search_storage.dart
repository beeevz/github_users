import 'package:get_it/get_it.dart';
import 'package:github_users/data/network/result.dart';
import 'package:github_users/data/search_storage/model/search.dart';
import 'package:github_users/data/search_storage/search_storage_error.dart';
import 'package:github_users/data/storage/database_client.dart';
import 'package:sqflite/sqflite.dart';

class SearchStorage {
  final dbClient = GetIt.instance<DatabaseClient>();

  // Insert a search query but limit entries to 10
  Future<Result<Null, SearchStorageError>> insertSearch(Search search) async {
    final db = await dbClient.database;

    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM search_queries'),
    );

    if (count != null && count >= 10) {
      await db.rawDelete(
        'DELETE FROM search_queries WHERE rowid = (SELECT rowid FROM search_queries ORDER BY rowid ASC LIMIT 1)',
      );
    }

    final result = await db.insert(
      'search_queries',
      search.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (result != 0) {
      return Success(null);
    } else {
      return Error(SearchStorageError());
    }
  }

  // Retrieve all Search Queries
  Future<Result<List<Search>, SearchStorageError>> getSearchQueries() async {
    try {
      final db = await dbClient.database;
      final List<Map<String, dynamic>> maps = await db.query('search_queries');
      final queryList = List.generate(
        maps.length,
        (i) => Search.fromMap(maps[i]),
      );
      return Success(queryList);
    } catch (e) {
      return Error(SearchStorageError());
    }
  }
}
