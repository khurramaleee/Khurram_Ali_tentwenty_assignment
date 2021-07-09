import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:http/http.dart' as http;
import 'package:tentwenty_project/services/Utility.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;
  delete(int id) async {
    final db = await database;
    db.delete("movies", where: "id = ?", whereArgs: [id]);
  }
  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await
    getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "moviedatabase.db");
    return await openDatabase(
        path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE movies ("
                  "id INTEGER,"
                  "name TEXT,"
                  "description TEXT,"
                  "releasedate INTEGER,"
                  "image TEXT"
                  ")"
          );

        }
    );
  }
  Future<List<movies>> getAllProducts() async {
    final db = await database;
    List<Map> results = await db.query(
        "movies", columns: movies.columns, orderBy: "id ASC"
    );
    List<movies> products = new List();
    results.forEach((result) {
      movies movie = movies.fromJson(result);
      products.add(movie);
    });
    return products;
  }
  Uint8List _bytesImage;



  insert(movies movie) async {
    final db = await database;

    var maxIdResult = await db.rawQuery("SELECT MAX(id)+2 as last_inserted_id FROM movies");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into movies (id, name, description, releasedate, image)"
            " VALUES (?, ?, ?, ?, ?)",
        [movie.id,movie.originalTitle, movie.overview, movie.releaseDate, "https://image.tmdb.org/t/p/original/"+movie.posterPath],

    );
    return result;
  }
}
Future<String> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(imageUrl);
  final bytes = response?.bodyBytes;
  return (bytes != null ? base64Encode(bytes) : null);
}
