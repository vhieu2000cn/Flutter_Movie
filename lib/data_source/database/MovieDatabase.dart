import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/MovieFavouriteResultItem.dart';

class MovieDatabase {
  MovieDatabase._internal();

  static final MovieDatabase db = MovieDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), "MovieDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Movie_Favourite ("
          "id INTEGER PRIMARY KEY,"
          "movieResult TEXT,"
          "isFavourite BOOLEAN"
          ")");
    });
  }

  Future<List<MovieFavouriteResultItem>> getListMovieFavourite() async {
    final db = await database;
    var res = await db.query('Movie_Favourite');
    List<MovieFavouriteResultItem> list = res.isNotEmpty
        ? res
            .map((resItem) => MovieFavouriteResultItem.fromMap(resItem))
            .toList()
        : [];
    return list;
  }

  Future<int> insertMovieFavourite(
      MovieFavouriteResultItem movieFavouriteResultItem) async {
    final db = await database;
    return await db.insert(
      'Movie_Favourite',
      movieFavouriteResultItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteMovieFavourite(
      int idMovieFavouriteResultItem) async {
    final db = await database;
    return await db.delete(
      'Movie_Favourite',
      where: 'id = ?',
      whereArgs: [idMovieFavouriteResultItem]
    );
  }
}
