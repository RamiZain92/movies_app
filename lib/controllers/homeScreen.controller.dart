import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies_app/views/pages/favorites.dart';

import '../api/serviceAPi/moviesAndTv.api.dart';
import '../models/movie.dart';
import '../models/tv.dart';
import '../utill/cache_helper.dart';
import '../views/pages/movies.dart';
import '../views/pages/search.dart';
import '../views/pages/topRatedMovies.dart';

class HomeScreenController extends GetxController {
  List<Movie> moviesFav = [];
  List<Movie> movies = [];
  List<Movie> topRatedMovies = [];
  List<Tv> tv = [];
  List<Movie> filteredMovies = [];
  List<Tv> filteredTV = [];
  bool spinnerMovies = true;
  int indexScreen = 0;

  List<Widget> screens = [
    Movies(),
    Favorites(),
    TopRatedMovies(),
    Search(),
  ];

  @override
  void onInit() {
    getMovies();
    getTv();
    super.onInit();
  }


  void selectItem(value) {
    indexScreen = value;
    update();
  }

  Future getMovies() async {
    spinnerMovies = true;
    update();
    movies = await MoviesAndTvApi().getMovies();
    spinnerMovies = false;
    update();
  }

  Future getTv() async {
    spinnerMovies = true;
    update();
    tv = await MoviesAndTvApi().getTv();
    spinnerMovies = false;
    update();
  }

  Future getTopRatedMovies() async {
    spinnerMovies = true;
    update();
    topRatedMovies = await MoviesAndTvApi().getTopRatedMovies();
    spinnerMovies = false;
    update();
  }

  void setMoviesFav(int index,List<Movie> movies) {
    CacheHelper.sharedPreferences!
        .setInt("${movies[index].id}", movies[index].id);
    update();
  }

  void delMoviesFav(index,List list) {
    CacheHelper.sharedPreferences!.remove("${list[index].id}");
    update();
  }

  void getMoviesFav() {
    moviesFav.clear();
    for (var element in movies) {
      if (CacheHelper.getData(key: "${element.id}") != null) {
        moviesFav.add(element);
      }
    }
  }

  void filterMovies(String query) {
    filteredMovies = movies
        .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  void filterTVShows(String query) {
    filteredTV = tv
        .where((show) => show.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }
}
