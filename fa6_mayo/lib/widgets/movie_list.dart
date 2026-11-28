import 'package:fa6_mayo/models/movies.dart';
import 'package:fa6_mayo/widgets/movie_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.movies, required this.removeBook});

  final List<Movie> movies;
  final void Function(Movie movie) removeBook;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (ctx, index) {
        final movie = movies[index];
        return Dismissible(
          key: ValueKey(movie.id),
          direction: DismissDirection.horizontal,

          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart){
              return true;
            }

            return false;
          },

          onDismissed: (direction) {
            removeBook(movies[index]);
          },

          background: Container(
            color: Colors.lightGreen,
            margin: Theme.of(context).cardTheme.margin,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
          ),

          secondaryBackground: Container(
            color: Colors.redAccent,
            margin: Theme.of(context).cardTheme.margin,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 20),
          ),

          child: MovieItem(movies[index]),
        );
      },
    );
  }
}
