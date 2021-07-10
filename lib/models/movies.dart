
class movies {

  String id;

  String originalTitle;
  String overview;
  bool adult;
  String posterPath;
  String releaseDate;
  static final columns = ["id", "original_title", "overview", "release_date", "poster_path"];
  movies(
      {
        this.id,
        this.adult,
        this.originalTitle,
        this.overview,

        this.posterPath,
        this.releaseDate,
        });

  factory movies.fromJson(Map<String, dynamic> json) {
    return new movies(


    id : json['id'].toString(),
    adult:json['adult'],
    originalTitle : json['original_title'],
    overview : json['overview'],

    posterPath : json['poster_path'],
    releaseDate : json['release_date'],

    );
    }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['id'] = this.id;
    data['adult'] = this.adult;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;

    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;

    return data;
  }
}