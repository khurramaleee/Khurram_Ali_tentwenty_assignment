
class movies {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  String id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  String voteAverage;
  String voteCount;
  static final columns = ["id", "originalTitle", "overview", "releaseDate", "image"];
  movies(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  factory movies.fromJson(Map<String, dynamic> json) {
    return new movies(
        adult : json['adult'],
        backdropPath : json['backdrop_path'],
        genreIds :json['genre_ids'].cast<int>(),
    id : json['id'].toString(),
    originalLanguage :json['original_language'],
    originalTitle : json['original_title'],
    overview : json['overview'],
    popularity : json['popularity'],
    posterPath : json['poster_path'],
    releaseDate : json['release_date'],
    title : json['title'],
    video : json['video'],
    voteAverage : json['vote_average'].toString(),
    voteCount : json['vote_count'].toString(),
    );
    }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}