import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/utils/constants.dart';
import 'package:library_app/features/book_storing/presentation/bloc/books_bloc.dart';
import 'package:library_app/features/book_storing/presentation/pages/add_book_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: BlocProvider(BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) =>
      )child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => _openAddBookPage(context),
                  child: const Text("Add Book")),
              ElevatedButton(
                  onPressed: () => _openAddBookPage(context),
                  child: const Text("All Books")),
            ],
          ),
        ),
      ),)
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddBookPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddBookPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddBookPage()),
    );
  }
}
