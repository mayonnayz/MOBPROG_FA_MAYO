import 'package:flutter/material.dart';
import 'package:fa6_mayo/models/movies.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({
    super.key, required void Function() onBack,
  });

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final List<Movie> listedMovies = [
    Movie(
      id: 1,
      title: 'P.S. I Still Love You',
      // author: 'Jenny Han',
      // pages: 337,
      rating: 4.2,
      year: '2024',
      // genre: Genre.romance, 
      // status: Status.finished,
    ),
    Movie(
      id: 2,
      title: 'Hunger Games',
      // author: 'Suzanne Collins',
      // pages: 374,
      rating: 5, 
      year: '2024',
      // genre: Genre.scienceFiction, 
      // status: Status.finished,
    ),
    Movie(
      id: 3,
      title: 'The Ballad of Songbirds and Snakes',
      // author: 'Suzanne Collins',
      // pages: 528,
      rating: 0,
      year: '2024',
      // genre: Genre.scienceFiction, 
      // status: Status.currentlyReading,
    ),
    Movie(
      id: 6,
      title: 'Twilight',
      // author: 'Stephenie Meyer',
      // pages: 498,
      rating: 0,
      year: '2024',
      // genre: Genre.fantasy, 
      // status: Status.wantToRead,
    ),
    Movie(
      id: 8,
      title: 'The Night Angel Trilogy',
      // author: 'Brent Weeks',
      // pages: 1872,
      // genre: Genre.fantasy, 
      rating: 4.5,
      year: '2024',
      // status: Status.finished,
    ),
  ];

  void _removeBook(Movie movie) {
    final movieIndex = listedMovies.indexOf(movie);

    setState(() {
      listedMovies.remove(movie);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Movie removed.'),
        duration: Duration(seconds: 3),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'Nothing to see here...',
        textAlign: TextAlign.center,
      ),
    );

    if (listedMovies.isNotEmpty) {
      mainContent = listedMovies as Widget;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Zy\'s Bookshelf'),
      ),
      body: Column(
        // children: [
        //   Chart(
        //     books: listedBooks,
        //     genre: availableGenres,
        //   ),
        //   Summary(
        //     books: listedBooks,
        //   ),
        //   Text('Swipe entry to left to remove, swipe to right to edit!', style: Theme.of(context).textTheme.titleSmall),
        //   Expanded(
        //     child: mainContent,
        //   ),
        // ],
      ),
    );
  }
}

class Movies {
}