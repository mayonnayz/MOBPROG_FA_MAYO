import 'package:fa3_my_reading_list_expdisthmcrt/bookshelf/bookshelf_item.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  const BookList({super.key, required this.books, required this.removeBook, required this.editBook});

  final List<Book> books;
  final void Function(Book book) removeBook;
  final void Function(Book book) editBook;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (ctx, index) {
        final book = books[index];
        return Dismissible(
          key: ValueKey(book.id),
          direction: DismissDirection.horizontal,

          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart){
              return true;
            }

            if (direction == DismissDirection.startToEnd){
              editBook(book);
              return false;
            }

            return false;
          },

          onDismissed: (direction) {
            removeBook(books[index]);
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

          child: BookItem(books[index]),
        );
      },
    );
  }
}
