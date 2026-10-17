import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final wantToRead = books
        .where((book) => book.status == Status.wantToRead)
        .length;

    final currentlyReading = books
        .where((book) => book.status == Status.currentlyReading)
        .length;

    final finished = books
        .where((book) => book.status == Status.finished)
        .length;

    final totalBooks = books.length;

    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reading Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _summaryRow('Want to Read: ', wantToRead),
                    _summaryRow('Currently Reading: ', currentlyReading),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _summaryRow('Finished: ', finished),
                    _summaryRow('Total Books: ', totalBooks),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, int count) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label),
          Text(count.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
