import 'package:flutter/foundation.dart';
import 'package:tentwenty_project/models/movie_detail.dart';

import 'package:tentwenty_project/services/movie_detail_api.dart';

enum HomeState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class detail_movie_model extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;


  String message = '';
  Map<String,dynamic> detail;
  detail_movie_model(id) {

    _fetchmovie_detail(id);
  }

  HomeState get homeState => _homeState;


  Future<void> _fetchmovie_detail(id) async {
    _homeState = HomeState.Loading;
    try {


      detail = (await movie_detail_api.instance.getmovie_detail(id)) ;
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      print("ye hy error"+e.toString());


      _homeState = HomeState.Error;
    }
    notifyListeners();
  }


}

