import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:http/http.dart' as http;
import 'package:tentwenty_project/services/Utility.dart';

class SQLiteDbProvider extends ChangeNotifier {
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
   try{

     Directory documentsDirectory = await
     getApplicationDocumentsDirectory();
     String path = join(documentsDirectory.path, "movie_database.db");
     return await openDatabase(
         path, version: 1,
         onOpen: (db) {},
         onCreate: (Database db, int version) async {
           await db.execute("CREATE TABLE movie ("
               "id INTEGER,"
               "original_title TEXT,"
               "overview TEXT,"
               "release_date TEXT,"
               "poster_path TEXT"
               ")");

         }
     );
   }catch(e){
     print(e);
   }
  }
  Future<List<movies>> getAllMovies() async {
    try{
      final db = await database;
      List<Map> results = await db.query(
          "movie", columns: movies.columns, orderBy: "id ASC"
      );
      List<movies> movielist = new List();
      print("get movie is callng from here");
      results.forEach((result) {
        movies movie = movies.fromJson(result);
        movielist.add(movie);
        print("get movie is callng from here"+movielist.first.originalTitle);
        print( movielist.first.posterPath);
      });
      return movielist;
    }
    catch(e){
      print("============>"+e.toString());
    }




  }

  Addmovie(movies movie) async {
    final db = await database;
    print("add movie is callng");


    var result = await db.rawInsert(
        "INSERT Into movie (id, original_title, overview, release_date, poster_path)"
            " VALUES (?, ?, ?, ?, ?)",
        [movie.id,movie.originalTitle, movie.overview, movie.releaseDate, "https://image.tmdb.org/t/p/original/"+movie.posterPath],

    ).then((value) {

      getAllMovies();
      print( getmovie( movie.id));



    });



  }
   getmovie( id) async {

    final db = await database;
    var res =await  db.query("movie", where: "id = ?", whereArgs: [id]);

    return movies.fromJson(res.first).id;


  }
}

