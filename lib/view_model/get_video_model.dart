import 'package:flutter/foundation.dart';
import 'package:tentwenty_project/models/movie_detail.dart';
import 'package:tentwenty_project/services/gettrailer.dart';

import 'package:tentwenty_project/services/movie_detail_api.dart';

enum video_state {
  Initial,
  Loading,
  Loaded,
  Error,
}

class get_video_model extends ChangeNotifier {
  video_state _videostate = video_state.Initial;


  String message = '';
  Map<String,dynamic> detail;
  get_video_model(id) {

    _fetch_video(id);
  }

  video_state get videostate => _videostate;


  Future<void> _fetch_video(id) async {
    _videostate = video_state.Loading;
    try {


      detail = (await gettrailer.instance.get_trailer(id)) ;
      _videostate = video_state.Loaded;
    } catch (e) {
      message = '$e';



      _videostate = video_state.Error;
    }
    notifyListeners();
  }


}

