import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:tentwenty_project/enums/connectivity_status.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:tentwenty_project/services/Utility.dart';
import 'package:tentwenty_project/services/cachng_api_data.dart';
import 'package:tentwenty_project/services/database.dart';
import 'package:tentwenty_project/ui/movie_detail_ui.dart';
import 'package:tentwenty_project/view_model/movie_model.dart';
class Home extends StatelessWidget {
var bytes;
Future<String> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(imageUrl);
  final bytes = response?.bodyBytes;
  return (bytes != null ? base64Encode(bytes) : null);
}
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('TenTwenty Porject'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => movie_model(""),
        child: Builder(builder: (context) {
          final model = Provider.of<movie_model>(context);

          if (model.homeState == HomeState.Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (model.homeState == HomeState.Error) {
          print('An Error Occured ${model.message}');
          }
          final movies_index = model.movies_list;
          var connectionStatus = Provider.of<ConnectivityStatus>(context);
          if (connectionStatus == ConnectivityStatus.online) {
            final key = new GlobalKey<ScaffoldState>();
            return ListView.builder(
              itemCount: movies_index.length,
              itemBuilder: (context, index) {
                final movie = movies_index[index];
                SQLiteDbProvider.db.Addmovie(movie);
                return Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 80,
                                  minHeight: 80,
                                  maxWidth: 80,
                                  maxHeight: 80,
                                ),
                                //
                                child:CachedNetworkImage(
                                  imageUrl: "https://image.tmdb.org/t/p/original/"+movie.posterPath,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      CircularProgressIndicator(value: downloadProgress.progress),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText.rich(
                                TextSpan(text:movie.title,),
                                style: TextStyle(fontSize: 12,color: Colors.black),
                                textAlign :TextAlign.start,
                                minFontSize: 1,

                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,


                              ),
                              AutoSizeText.rich(

                                TextSpan(text:movie.releaseDate,),
                                textAlign :TextAlign.right,
                                style: TextStyle(fontSize: 12,color: Colors.black),

                                minFontSize: 1,

                              ),

                              AutoSizeText.rich(

                                TextSpan(text:movie.adult=="true"?"Adult":"Non adult",),
                                textAlign :TextAlign.start,
                                style: TextStyle(fontSize: 12,color: Colors.black),

                                minFontSize: 1,

                              ),


                            ],
                          ),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(

                                    child:ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // dou
                                          primary: Colors.white, //background color of button
                                          side: BorderSide(width:1, color:Colors.blue), //border width and color
                                          elevation: 1, //elevation of button
                                          shape: RoundedRectangleBorder( //to set border radius to button
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          //content padding inside button
                                        ),
                                        onPressed: (){
                                          Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (context) => movie_detail_ui(id:movie.id),
                                            ),
                                          );
                                        },
                                        child: Text("Book",style: TextStyle(color: Colors.black),)
                                    )
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),

                    ),
                    Divider(
                      color: Colors.grey,
                      endIndent: 10.0,
                      indent: 10.0,
                    )
                  ],
                );




              },
            );
          }
          else  {
            return
              FutureBuilder<List<movies>>(
                future: SQLiteDbProvider.db.getAllMovies(),
                builder: (context, snapshot){
                    return ListView.builder(
                      itemCount: movies_index.length,
                      itemBuilder: (context, index) {
                        final movie = movies_index[index];
                        SQLiteDbProvider.db.Addmovie(movie);
            print(movie.posterPath);

                        return Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: 80,
                                          minHeight: 80,
                                          maxWidth: 80,
                                          maxHeight: 80,
                                        ),
                                        child:
                                        CachedNetworkImage(
                                          imageUrl: "https://image.tmdb.org/t/p/original/"+movie.posterPath,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),


                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText.rich(
                                        TextSpan(text:movie.title,),
                                        style: TextStyle(fontSize: 12,color: Colors.black),
                                        textAlign :TextAlign.start,
                                        minFontSize: 1,

                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,


                                      ),
                                      AutoSizeText.rich(

                                        TextSpan(text:movie.releaseDate,),
                                        textAlign :TextAlign.right,
                                        style: TextStyle(fontSize: 12,color: Colors.black),

                                        minFontSize: 1,

                                      ),

                                      AutoSizeText.rich(

                                        TextSpan(text:movie.adult=="true"?"Adult":"Non adult",),
                                        textAlign :TextAlign.start,
                                        style: TextStyle(fontSize: 12,color: Colors.black),

                                        minFontSize: 1,

                                      ),


                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(

                                            child:ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  // dou
                                                  primary: Colors.white, //background color of button
                                                  side: BorderSide(width:1, color:Colors.blue), //border width and color
                                                  elevation: 1, //elevation of button
                                                  shape: RoundedRectangleBorder( //to set border radius to button
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  //content padding inside button
                                                ),
                                                onPressed: (){
                                                  Scaffold.of(context).showSnackBar(new SnackBar(
                                                    content: new Text("You are currently offline"),
                                                  ));
                                                },
                                                child: Text("Book",style: TextStyle(color: Colors.black),)
                                            )
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),

                            ),
                            Divider(
                              color: Colors.grey,
                              endIndent: 10.0,
                              indent: 10.0,
                            )
                          ],
                        );




                      },
                    );

                },
              );


          }

        }),
      ),
    );
  }

}