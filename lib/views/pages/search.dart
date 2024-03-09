import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/tv.dart';

import '../../controllers/homeScreen.controller.dart';
import '../../models/movie.dart';
import '../../utill/cache_helper.dart';
import 'movieDetails.dart';

class Search extends StatelessWidget {
  Search({Key? key});

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Search Movies',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              // Filter movies based on search value
              controller.filterMovies(value);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.filteredMovies.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _builderWidget(
                  controller.filteredMovies[index], context, controller, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTVShowsTab(HomeScreenController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Search TV Shows',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              // Filter TV shows based on search value
              controller.filterTVShows(value);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.filteredTV.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _builderWidget2(controller.filteredTV[index], context);
            },
          ),
        ),
      ],
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
            fit: BoxFit.fill,
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
                  controller.delMoviesFav(index, controller.filteredMovies);
                } else {
                  controller.setMoviesFav(index, controller.filteredMovies);
                }
              },
              icon: Icon(
                Icons.favorite,
                size: MediaQuery.of(context).size.width * 0.1, // Adjust icon size based on screen width
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
          fit: BoxFit.fill,
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
