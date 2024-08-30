
class Movie{
  String title;
  String backDropPath;
  String originalTitle;
  String overView;
  String posterPath;
  String releaseDate;
  double voteAverage;

  Movie({
   required this.title,
   required this.backDropPath,
   required this.originalTitle,
   required this.overView,
   required this.posterPath,
   required this.releaseDate,
   required this.voteAverage
  });


  factory Movie.fromJson(Map<String,dynamic>comingasmap){
    return Movie(title: comingasmap["title"], 
    backDropPath: comingasmap['backdrop_path'],
     originalTitle: comingasmap['original_title'],
      overView: comingasmap['overview'], 
      posterPath: comingasmap['poster_path'],
       releaseDate: comingasmap['release_date'], 
       voteAverage: (comingasmap['vote_average']as num).toDouble());
  }
}
