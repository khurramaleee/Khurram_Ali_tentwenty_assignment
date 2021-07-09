import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:tentwenty_project/models/movies.dart';

class caching_api_data {
  static caching_api_data _instance;
  caching_api_data._();

  static caching_api_data get instance {
    if (_instance == null) {
      _instance = caching_api_data._();
    }
    return _instance;
  }
  final String API_URL = "https://api.themoviedb.org/3/movie/upcoming?api_key=647793d492f6f3b1407143a2f15bd54e";

  Future<List<movies>> getUserDataResponse() async {


    String fileName = "CacheData.json";
    var cacheDir = await getTemporaryDirectory();



    if (await File(cacheDir.path + "/" + fileName).exists()) {
      print("Loading from cache");
      //TOD0: Reading from the json File
      var jsonData = File(cacheDir.path + "/" + fileName).readAsStringSync();
      List<movies> response = movies.fromJson(json.decode(jsonData)["results"]) as List<movies>;
      return response;
    }


    else {
      print("Loading from API");
      var response = await http.get(API_URL);

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        final List<dynamic> responseBody = jsonDecode(jsonResponse)["results"];

        List<movies> moviee = responseBody.map((responseBody)=> movies.fromJson(responseBody)).toList();


        var tempDir = await getTemporaryDirectory();
        File file = new File(tempDir.path + "/" + fileName);
        file.writeAsString(jsonResponse, flush: true, mode: FileMode.write);

        return moviee;
      }
    }
  }
}