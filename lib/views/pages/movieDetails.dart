import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../../utill/cache_helper.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int? userRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/w200${widget.movie.backdropPath}",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.3, // Adjust image height based on screen size
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.movie.releaseDate,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.movie.overview,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Your Rating: ${CacheHelper.getData(key: "${widget.movie.id}/${widget.movie.title}") ?? "Not rated"}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      _showRatingDialog();
                    },
                    child: Text(
                      'Rate This Movie',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate this movie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select your rating:'),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      onPressed: () {
                        userRating = i;
                        setMoviesRate(userRating!, widget.movie.id, widget.movie.title);
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.star,
                        color: CacheHelper.getData(key: "${widget.movie.id}/${widget.movie.title}") != null &&
                            CacheHelper.getData(key: "${widget.movie.id}/${widget.movie.title}") >= i
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8.0),
              if (CacheHelper.getData(key: "${widget.movie.id}/${widget.movie.title}") != null)
                InkWell(
                  onTap: () {
                    delMoviesRate(widget.movie.title, widget.movie.id);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Row(
                    children: [
                      Spacer(),
                      Icon(Icons.delete_forever_outlined),
                      SizedBox(width: 3.0),
                      Text('Delete your rating'),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  void setMoviesRate(int userRate, int id, String title) {
    CacheHelper.sharedPreferences!.setInt("$id/$title", userRate);
  }

  void delMoviesRate(String title, int id) {
    CacheHelper.sharedPreferences!.remove("$id/$title");
  }
}
