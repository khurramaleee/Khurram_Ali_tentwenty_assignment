import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tentwenty_project/models/movie_detail.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:tentwenty_project/ui/movie_detail_ui.dart';

class movie_detail_api {
  static movie_detail_api _instance;

  movie_detail_api._();

  static movie_detail_api get instance {
    if (_instance == null) {
      _instance = movie_detail_api._();
    }
    return _instance;
  }


  Future<Map<String,dynamic>> getmovie_detail(String id) async {

    final getUser =
    await http.get('https://api.themoviedb.org/3/movie/$id?api_key=647793d492f6f3b1407143a2f15bd54e&language=en-US', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    final responseBody = jsonDecode((getUser.body));
 // print(responseBody);

    return responseBody ;


  }

}