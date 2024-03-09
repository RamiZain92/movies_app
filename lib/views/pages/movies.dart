import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/tv.dart';

import '../../controllers/homeScreen.controller.dart';
import '../../models/movie.dart';
import '../../utill/cache_helper.dart';
import 'movieDetails.dart';

class Movies extends StatelessWidget {
  Movies({Key? key}) : super(key: key);

  final homeController = Get.lazyPut(() => HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Movie App'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Movies'),
                  Tab(text: 'TV Shows'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildMoviesTab(controller),
                _buildTVShowsTab(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoviesTab(HomeScreenController controller) {
    return ListView.builder(
      itemCount: controller.movies.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _builderWidget(controller.movies[index], context, controller, index);
      },
    );
  }

  Widget _buildTVShowsTab(HomeScreenController controller) {
    return ListView.builder(
      itemCount: controller.tv.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _builderWidget2(controller.tv[index], context);
      },
    );
  }

  Widget _builderWidget(Movie model, context, controller, index) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      InkWell(
        onTap: () {
          Get.to(MovieDetailPage(movie: model));
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Image.network(
            "https://image.tmdb.org/t/p/original/${model.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Card(
                    color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                if (CacheHelper.getData(key: "${model.id}") != null) {
                  controller.delMoviesFav(index, controller.movies);
                } else {
                  controller.setMoviesFav(index, controller.movies);
                }
              },
              icon: Icon(
                Icons.favorite,
                size: MediaQuery.of(context).size.width * 0.08,
                color: CacheHelper.getData(key: "${model.id}") != null ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _builderWidget2(Tv model, context) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Image.network(
          "https://image.tmdb.org/t/p/original/${model.backdropPath}",
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Placeholder(); // Placeholder widget to show when image fails to load
          },
        ),
      ),
      Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Card(
                    color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
