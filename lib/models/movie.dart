
class Movie {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  late bool adult;
  late String backdropPath;
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  Movie.fromJson(Map<String, dynamic> json){
    adult = json['adult'] ?? false;
    backdropPath = json['backdrop_path'] ?? "";
    id = json['id'] ?? 0;
    originalLanguage = json['original_language'] ?? "";
    originalTitle = json['original_title'] ?? "";
    overview = json['overview'] ?? "";
    popularity = json['popularity'] ?? 0.0;
    posterPath = json['poster_path'] ?? "";
    releaseDate = json['release_date'] ?? "";
    title = json['title'] ?? "";
    video = json['video'] ?? false;
    voteAverage = json['vote_average'] ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
  }
}