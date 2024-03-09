import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/homeScreen.controller.dart';
import '../utill/spiner.base.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/";
  HomeScreen({Key? key});

  final homeController = Get.lazyPut(() => HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        if (controller.spinnerMovies == true) {
          return SpinerBase();
        }
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 6,
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favorite"),
                BottomNavigationBarItem(icon: Icon(Icons.trending_up_outlined,), label: "Top Rated"),
                BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Search"),
              ],
              currentIndex: controller.indexScreen,
              onTap: (index) {
                controller.selectItem(index);
                switch (index) {
                  case 0:
                    controller.getMovies();
                    controller.getTv();
                    break;
                  case 1:
                    controller.getMoviesFav();
                    break;
                  case 2:
                    controller.getTopRatedMovies();
                    break;
                  case 3:
                    break;
                }
              },
            ),
          ),
          body: controller.screens[controller.indexScreen],
        );
      },
    );
  }
}
