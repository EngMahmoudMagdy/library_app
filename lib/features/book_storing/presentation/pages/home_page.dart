import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/utils/constants.dart';
import 'package:library_app/features/book_storing/presentation/bloc/books_bloc.dart';
import 'package:library_app/features/book_storing/presentation/pages/add_book_page.dart';
import 'package:library_app/features/book_storing/presentation/widgets/book_item.dart';

import '../../../../injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    di<BooksBloc>().add(GetAllBooksEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: BlocConsumer<BooksBloc, BooksState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: Column(
                  children: const [
                    Text(
                      "Loading...",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Column(
                  children: [
                    const Text(
                      "Error, Please try again",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _refreshAndFetchBooks,
                        child: const Text("Refresh")),
                  ],
                ),
              );
            } else if (state is AllBooksRetrieveState) {
              return SingleChildScrollView(
                child: Center(
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      final item = state.list[index];
                      return BookItem(bookModel: item);
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    const Text(
                      "No data available!",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _refreshAndFetchBooks,
                        child: const Text("Refresh")),
                  ],
                ),
              );
            }
          }),
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

  void _refreshAndFetchBooks() {}
}
