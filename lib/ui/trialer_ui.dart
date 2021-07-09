import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_project/models/movie_detail.dart';
import 'package:tentwenty_project/view_model/detail_movie_model.dart';
import 'package:tentwenty_project/view_model/get_video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class trailer_ui extends StatelessWidget {
  final String id;

  trailer_ui({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => get_video_model(id),
        child: Builder(builder: (context) {
          final video_model = Provider.of<get_video_model>(context);

          if (video_model.videostate == video_state.Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (video_model.videostate == video_state.Error) {
            print('An Error Occured ${video_model.message}');
          }
          final video_data = video_model.detail;


          return Scaffold(

              body:   SingleChildScrollView(
                child: Column(
                  children: [
                    Container(child:YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: video_data["results"][0]["key"],
                        //Add videoID.
                        flags: YoutubePlayerFlags(
                          hideControls: false,

                          controlsVisibleAtStart: true,
                          autoPlay: true,
                          mute: false,

                        ),

                      ),
                      showVideoProgressIndicator: true,
                      onEnded: (e){
                        Navigator.pop(context);
                      },
                    ),



                    ),

                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(

                          child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                                child: Text("Done"),
                              )
                          ) ,

                        )
                    ),
                  ],
                ),
              ));


        }),
      ),
    );
  }

}


