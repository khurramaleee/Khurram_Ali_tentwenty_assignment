import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_project/models/movie_detail.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:tentwenty_project/view_model/detail_movie_model.dart';

class movie_detail_ui extends StatelessWidget {
  final String id;

   movie_detail_ui({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => detail_movie_model(id),
        child: Builder(builder: (context) {
          final detail_model = Provider.of<detail_movie_model>(context);

          if (detail_model.homeState == HomeState.Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (detail_model.homeState == HomeState.Error) {
            print('An Error Occured ${detail_model.message}');
          }
          final movies_details = detail_model.detail;
          print("=-======="+movies_details.toString());
          return Scaffold(

              body:   NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 200.0,
                        floating: false,
                        pinned: true,
                        backgroundColor: Colors.black,

                        flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            // title: Text(movies_details["original_title"],
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 16.0,
                            //     )),
                            background:Image.network(
                              "https://image.tmdb.org/t/p/original/"+movies_details["poster_path"],
                              fit: BoxFit.cover,
                            )

                        ),
                      ),
                    ];
                  },
                 body: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: AutoSizeText.rich(

                            TextSpan(text:movies_details["original_title"],),
                            style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                            textAlign :TextAlign.start,
                            minFontSize: 1,

                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,


                          ) ,
                        ),
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Center(

                           child: RaisedButton(
                             onPressed: () {
                               Navigator.push(context,
                                 MaterialPageRoute(
                                   builder: (context) => movie_detail_ui(id:movie.id),
                                 ),
                               );
                             },
                             child: Padding(
                               padding: const EdgeInsets.fromLTRB(95,0,95,0),
                               child: Text("Watch Trailer"),
                             )
                           ) ,

                         )
                       ),
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: AutoSizeText.rich(

                           TextSpan(text:"Genres"),
                           style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
                           textAlign :TextAlign.start,
                           minFontSize: 1,

                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,


                         ) ,
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                         child: AutoSizeText.rich(

                           TextSpan(text:movies_details["genres"][0]["name"]),
                           style: TextStyle(fontSize: 12,color: Colors.black),
                           textAlign :TextAlign.start,
                           minFontSize: 1,

                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,


                         ) ,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: AutoSizeText.rich(

                           TextSpan(text:"Release Date"),
                           style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
                           textAlign :TextAlign.start,
                           minFontSize: 1,

                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,


                         ) ,
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                         child: AutoSizeText.rich(

                           TextSpan(text:movies_details["release_date"]),
                           style: TextStyle(fontSize: 12,color: Colors.black),
                           textAlign :TextAlign.start,
                           minFontSize: 1,

                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,


                         ) ,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: AutoSizeText.rich(

                           TextSpan(text:"OverView"),
                           style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
                           textAlign :TextAlign.start,
                           minFontSize: 1,

                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,


                         ) ,
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                         child: AutoSizeText.rich(

                           TextSpan(text:movies_details["overview"]),
                           style: TextStyle(fontSize: 16,color: Colors.black),
                           textAlign :TextAlign.start,
                           minFontSize: 1,

                           maxLines: 6,
                           overflow: TextOverflow.ellipsis,


                         ) ,
                       ),
                     ],
                   ),
                 ),


              ));


        }),
      ),
    );
  }
}

String data(movies_detail) {
  String genre;
  for(var data in movies_detail){
    genre=data["name"]+genre;
    print(genre);
  }
  return  genre;
}
