import 'package:flutter/material.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/presentation/pages/update_book_page.dart';

class BookItem extends StatelessWidget {
  final BookModel bookModel;

  const BookItem({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(bookModel.id.toString()),
        Text(bookModel.title.toString()),
        ElevatedButton(
          onPressed: () => _onUpdatePressed(context),
          child: const Text("Update"),
        ),
        ElevatedButton(
          onPressed: _onDeletePressed,
          child: const Text("Delete"),
        ),
      ],
    );
  }

  void _onUpdatePressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UpdateBookPage(),
        // Pass the arguments as part of the RouteSettings. The
        // DetailScreen reads the arguments from these settings.
        settings: RouteSettings(
          arguments: bookModel,
        ),
      ),
    );
  }

  void _onDeletePressed() {}
}
