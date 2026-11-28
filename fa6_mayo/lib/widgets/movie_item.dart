import 'package:fa6_mayo/models/movies.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  movie.year,
                  style: Theme.of(context).textTheme.titleSmall!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${movie.rating}/10',
                  style: Theme.of(context).textTheme.titleSmall!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    
  }
}
