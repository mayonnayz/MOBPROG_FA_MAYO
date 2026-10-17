import 'package:fa3_my_reading_list_expdisthmcrt/models/bookshelf.dart';
import 'package:flutter/material.dart';

class NewBook extends StatefulWidget {
  const NewBook({
    super.key,
    required this.addBook,
    required this.availableGenres,
    this.existingBook,
    this.updatedBook,
  });

  final void Function(Book book) addBook;
  final List<Genre> availableGenres;

  final Book? existingBook;
  final void Function(Book book)? updatedBook;

  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();
  final _ratingController = TextEditingController();
  Genre? _selectedGenre;
  Status? _selectedStatus;

  @override
  void initState() {
    super.initState();

    final book = widget.existingBook;

    if (book != null) {
      _titleController.text = book.title;
      _authorController.text = book.author;
      _pagesController.text = book.pages.toString();
      _ratingController.text = book.rating?.toString() ?? '';

      _selectedGenre = book.genre;
      _selectedStatus = book.status;
    }
  }

  void _submitBookData() {
    final pages = int.tryParse(_pagesController.text);
    final isFinished = _selectedStatus == Status.finished;

    final rating = isFinished ? double.tryParse(_ratingController.text) : null;

    if (_titleController.text.trim().isEmpty ||
        _authorController.text.trim().isEmpty ||
        pages == null ||
        pages < 20 ||
        _selectedGenre == null ||
        _selectedStatus == null ||
        (isFinished && (rating == null || rating < 0 || rating > 5 || rating == -0))) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please check your inputs. Title and author are required, '
            'pages must be at least 20, and finished books need a '
            'rating between 0 and 5.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );

      return;
    }

    final newBook = Book(
      id: widget.existingBook?.id,
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      pages: pages,
      rating: rating,
      genre: _selectedGenre!,
      status: _selectedStatus!,
    );

    final isEditing = widget.existingBook != null;

    if (isEditing) {
      widget.updatedBook!(newBook);
    } else {
      widget.addBook(newBook);
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Book Updated' : 'Book Added'),
        content: Text(
          '${isEditing ? 'Book has been updated successfully' : 'Book has been added successfully'} '
          '\nTitle: ${newBook.title}'
          '\nAuthor: ${newBook.author}'
          '\nPages: ${newBook.pages}'
          '\nRating: ${newBook.rating?.toString() ?? 'Not rated'}'
          '\nGenre: ${newBook.genre.name}'
          '\nStatus: ${newBook.status.readingStatus}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            20,
            16,
            20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Book Title'),
              ),
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              TextField(
                controller: _pagesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Pages',
                  hint: Text(
                    'At least 20 pages only.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: _ratingController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  hint: Text(
                    'Rate from 0-5 if finished.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButton<Genre>(
                value: _selectedGenre,
                hint: const Text('Select Genre'),
                isExpanded: true,
                items: widget.availableGenres.map((genre) {
                  return DropdownMenuItem<Genre>(
                    value: genre,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (genre.icon != null) ...[
                          Icon(genre.icon),
                          const SizedBox(width: 8),
                        ],
                        Text(genre.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGenre = value;
                  });
                },
              ),
              DropdownButton<Status>(
                value: _selectedStatus,
                hint: const Text('Select Reading Status'),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: Status.wantToRead,
                    child: Text('Want to Read'),
                  ),
                  DropdownMenuItem(
                    value: Status.currentlyReading,
                    child: Text('Currently Reading'),
                  ),
                  DropdownMenuItem(
                    value: Status.finished,
                    child: Text('Finished'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;

                    if (value != Status.finished) {
                      _ratingController.clear();
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _submitBookData,
                    child: Text(
                      widget.existingBook == null
                          ? 'Save Book'
                          : 'Save Changes',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
