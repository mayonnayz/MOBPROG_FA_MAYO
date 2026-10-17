import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf.dart';

class BookBucket {
  const BookBucket({
    required this.genre,
    required this.books,
  });

  BookBucket.forGenre(
    List<Book> allBooks,
    this.genre,
  ) : books = allBooks
          .where((book) => book.genre == genre)
          .toList();

  final Genre genre;
  final List<Book> books;

  int get totalBooks {
    return books.length;
  }
}
