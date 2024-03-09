
import '../../models/movie.dart';
import '../../models/tv.dart';
import '../api.dart';

class MoviesAndTvApi {

  Future<List<Movie>> getMovies() async {
    final respon = await Api().methodGet(
      "discover/movie",
    );
    if (respon == null) return [];
    switch (respon.statusCode) {
      case 200:
        return List.generate(respon.data['results'].length,
            (index) => Movie.fromJson(respon.data['results'][index]));
      case 404:
        return [];
      default:
        return [];
    }
  }

  Future<List<Tv>> getTv() async {
    final respon = await Api().methodGet(
      "discover/tv",
    );
    if (respon == null) return [];
    switch (respon.statusCode) {
      case 200:
        return List.generate(respon.data['results'].length,
                (index) => Tv.fromJson(respon.data['results'][index]));
      case 404:
        return [];
      default:
        return [];
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final respon = await Api().methodGet(
      "movie/top_rated",
    );
    if (respon == null) return [];
    switch (respon.statusCode) {
      case 200:
        return List.generate(respon.data['results'].length,
                (index) => Movie.fromJson(respon.data['results'][index]));
      case 404:
        return [];
      default:
        return [];
    }
  }

}
