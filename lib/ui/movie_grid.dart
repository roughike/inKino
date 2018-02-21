import 'package:flutter/material.dart';
import 'package:inkino/ui/movie_grid_item.dart';

class MovieGrid extends StatelessWidget {
  MovieGrid(this.movies);
  final List<Object> movies;

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        var movie = movies[index];
        return new MovieGridItem(index);
      },
    );
  }
}
