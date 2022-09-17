import 'package:flutter/material.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';

class BookItem extends StatelessWidget {
  final BookModel bookModel;

  const BookItem({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(bookModel.id.toString()),
        Text(bookModel.title.toString()),
        ElevatedButton(
          onPressed: _onUpdatePressed,
          child: const Text("Update"),
        ),
        ElevatedButton(
          onPressed: _onDeletePressed,
          child: const Text("Delete"),
        ),
      ],
    );
  }

  void _onUpdatePressed() {

  }

  void _onDeletePressed() {

  }
}
