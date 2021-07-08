import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tentwenty_project/models/movie_detail.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:tentwenty_project/ui/movie_detail_ui.dart';

class movie_api {
  static movie_api _instance;

  movie_api._();

  static movie_api get instance {
    if (_instance == null) {
      _instance = movie_api._();
    }
    return _instance;
  }

  Future<List<movies>> getmovies() async {

    final getUser =
    await http.get('https://api.themoviedb.org/3/movie/upcoming?api_key=647793d492f6f3b1407143a2f15bd54e', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    final List<dynamic> responseBody = jsonDecode(getUser.body)["results"];

    List<movies> moviee = responseBody.map((responseBody)=> movies.fromJson(responseBody)).toList();
    return moviee;


  }


}