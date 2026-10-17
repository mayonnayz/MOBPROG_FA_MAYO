import 'package:fa3_my_reading_list_expdisthmcrt/bookshelf/bookshelf_list.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/bookshelf/new_book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/chart/chart.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/summary/summary.dart';
import 'package:flutter/material.dart';

class BookshelfScreen extends StatefulWidget {
  const BookshelfScreen({
    super.key,
  });


  @override
  State<BookshelfScreen> createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  final List<Book> listedBooks = [
    Book(
      title: 'P.S. I Still Love You',
      author: 'Jenny Han',
      pages: 337,
      rating: 4.2,
      genre: Genre.romance, 
      status: Status.finished,
    ),
    Book(
      title: 'Hunger Games',
      author: 'Suzanne Collins',
      pages: 374,
      rating: 5,
      genre: Genre.scienceFiction, 
      status: Status.finished,
    ),
    Book(
      title: 'The Ballad of Songbirds and Snakes',
      author: 'Suzanne Collins',
      pages: 528,
      rating: null,
      genre: Genre.scienceFiction, 
      status: Status.currentlyReading,
    ),
    Book(
      title: 'Twilight',
      author: 'Stephenie Meyer',
      pages: 498,
      rating: null,
      genre: Genre.fantasy, 
      status: Status.wantToRead,
    ),
    Book(
      title: 'The Night Angel Trilogy',
      author: 'Brent Weeks',
      pages: 1872,
      rating: 4.5,
      genre: Genre.fantasy, 
      status: Status.finished,
    ),
  ];

  final List<Genre> availableGenres = [
    Genre.comedy,
    Genre.fantasy,
    Genre.historicalFiction,
    Genre.romance,
    Genre.scienceFiction,
  ];

  void _openBookModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewBook(
        addBook: _addBook,
        availableGenres: availableGenres,
      ),
    );
  }

  void _addBook(Book book) {
    setState(() {
      listedBooks.add(book);
    });
  }

  void _removeBook(Book book) {
    final bookIndex = listedBooks.indexOf(book);

    setState(() {
      listedBooks.remove(book);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Book removed.'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              listedBooks.insert(bookIndex, book);
            });
          },
        ),
      ),
    );
  }

  void _editBook(Book book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewBook(
        availableGenres: availableGenres,
        existingBook: book,
        addBook: _addBook,
        updatedBook: (updatedBook) {
          setState(() {
            final index = listedBooks.indexOf(book);
            if (index != -1) {
              listedBooks[index] = updatedBook;
            }
          });
        }
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'Every book is a journey waiting to unfold.\nAdd books to your list!',
        textAlign: TextAlign.center,
      ),
    );

    if (listedBooks.isNotEmpty) {
      mainContent = BookList(
        books: listedBooks,
        removeBook: _removeBook,
        editBook: _editBook,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Zy\'s Bookshelf'),
        actions: [
          IconButton(
            onPressed: _openBookModal,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(
            books: listedBooks,
            genre: availableGenres,
          ),
          Summary(
            books: listedBooks,
          ),
          Text('Swipe entry to left to remove, swipe to right to edit!', style: Theme.of(context).textTheme.titleSmall),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}