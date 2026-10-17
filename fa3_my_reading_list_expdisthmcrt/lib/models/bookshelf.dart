import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class Genre {
  final String name;
  final IconData? icon;

  const Genre({
    required this.name,
    this.icon,
  });

  static const romance = Genre(
    name: 'Romance',
    icon: Icons.favorite,
  );

  static const comedy = Genre(
    name: 'Comedy',
    icon: Icons.emoji_emotions,
  );

  static const scienceFiction = Genre(
    name: 'Science Fiction',
    icon: Icons.science_outlined,
  );

  static const fantasy = Genre(
    name: 'Fantasy',
    icon: Icons.emoji_nature_sharp,
  );

  static const historicalFiction = Genre(
    name: 'Historical Fiction',
    icon: Icons.access_time,
  );
}

class Status {
  final String readingStatus;

  const Status({
    required this.readingStatus
  });

  static const wantToRead = Status(
    readingStatus: 'Want to Read',
  );

  static const currentlyReading = Status(
    readingStatus: 'Currently Reading',
  );

  static const finished = Status(
    readingStatus: 'Finished',
  );
}

class Book {
  final String id;
  final String title;
  final String author;
  final int pages;
  final double? rating;
  final Genre genre;
  final Status status;

  Book({
    String? id,
    required this.title,
    required this.author,
    required this.pages,
    this.rating,
    required this.genre,
    required this.status,
  }) : id = Uuid().v4();

}