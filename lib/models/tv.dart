
class Tv {
  Tv({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });
  late bool adult;
  late String backdropPath;
  late int id;
  late String originalLanguage;
  late String originalName;
  late String overview;
  late double popularity;
  late String posterPath;
  late String firstAirDate;
  late String name;
  late double voteAverage;
  late int voteCount;

  Tv.fromJson(Map<String, dynamic> json){
    adult = json['adult'] ?? false;
    backdropPath = json['backdrop_path'] ?? "";
    id = json['id'] ?? 0;
    originalLanguage = json['original_language'] ?? "";
    originalName = json['original_name'] ?? "";
    overview = json['overview'] ?? "";
    popularity = json['popularity'] ?? 0.0;
    posterPath = json['poster_path'] ?? "";
    firstAirDate = json['first_air_date'] ?? "";
    name = json['name'] ?? "";
    voteAverage = json['vote_average'] ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
  }
}