import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tentwenty_project/models/movie_detail.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:tentwenty_project/ui/movie_detail_ui.dart';

class gettrailer {
  static gettrailer _instance;

  gettrailer._();

  static gettrailer get instance {
    if (_instance == null) {
      _instance = gettrailer._();
    }
    return _instance;
  }


  Future<Map<String,dynamic>> get_trailer(String id) async {

    final getvideo =
    await http.get('https://api.themoviedb.org/3/movie/$id/videos?api_key=647793d492f6f3b1407143a2f15bd54e&language=en-US', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    final responseBody = jsonDecode((getvideo.body));
    // print(responseBody);

    return responseBody ;


  }

}