import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem(this.book, {super.key});

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
                  book.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacer(),
                Text(book.rating?.toString() ?? 'Not rated', style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            Row(
              children: [
                Text(
                  book.author,
                  style: Theme.of(context).textTheme.titleSmall!
                      .copyWith(fontSize: 16),
                ),
                Spacer(),
                Text(book.status.readingStatus, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            Row(
              children: [
                Text(book.genre.name, style: Theme.of(context).textTheme.titleSmall),
                Spacer(),
                Text('${book.pages} pages', style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ],
        ),
      ),
    );
    
  }
}
