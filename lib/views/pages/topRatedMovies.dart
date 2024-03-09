import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/homeScreen.controller.dart';
import '../../models/movie.dart';
import 'movieDetails.dart';

class TopRatedMovies extends StatelessWidget {
  TopRatedMovies({Key? key});

  final homeController = Get.lazyPut(() => HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Movie App'),
          ),
          body: ListView.builder(
            itemCount: controller.topRatedMovies.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _builderWidget(controller.topRatedMovies[index], context, controller, index);
            },
          ),
        );
      },
    );
  }
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
            border: Border.all(color: Theme.of(context).primaryColor)),
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
                      style: TextStyle(color: Colors.white),
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
