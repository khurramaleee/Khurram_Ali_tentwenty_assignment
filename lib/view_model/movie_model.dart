import 'package:flutter/foundation.dart';
import 'package:tentwenty_project/models/movie_detail.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:tentwenty_project/services/movie_api.dart';
import 'package:tentwenty_project/services/movie_detail_api.dart';

enum HomeState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class movie_model extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  List<movies> movies_list = [];
  movie_detail movies_details;
  String message = '';

  movie_model(id) {
    _fetchmovie();

  }

  HomeState get homeState => _homeState;

  Future<void> _fetchmovie() async {
    _homeState = HomeState.Loading;
    try {
      await Future.delayed(Duration(seconds: 1));
      final movies_Api = await movie_api.instance.getmovies();

      movies_list = movies_Api.toList();
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }



}

