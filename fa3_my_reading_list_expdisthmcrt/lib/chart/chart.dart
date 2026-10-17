import 'package:fa3_my_reading_list_expdisthmcrt/chart/chart_bar.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf_bucket.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.books, required this.genre});

  final List<Book> books;
  final List<Genre> genre;

  List<BookBucket> get buckets {
    return genre
        .map((category) => BookBucket.forGenre(books, category))
        .toList();
  }

  int get maxTotalBooks {
    int maxTotalBooks = 0;

    for (final bucket in buckets) {
      if (bucket.totalBooks > maxTotalBooks) {
        maxTotalBooks = bucket.totalBooks;
      }
    }

    return maxTotalBooks;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  Expanded(
                    child: ChartBar(
                      fill: maxTotalBooks == 0
                          ? 0
                          : bucket.totalBooks / maxTotalBooks,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets.map((bucket) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    bucket.genre.icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
