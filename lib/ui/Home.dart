import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:tentwenty_project/models/movies.dart';
import 'package:tentwenty_project/ui/movie_detail_ui.dart';
import 'package:tentwenty_project/view_model/movie_model.dart';
class Home extends StatelessWidget {
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
          return ListView.builder(
            itemCount: movies_index.length,
            itemBuilder: (context, index) {
              final movie = movies_index[index];
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
                              child: Image.network(
                                  "https://image.tmdb.org/t/p/original/"+movie.posterPath
                              )
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
        }),
      ),
    );
  }
}