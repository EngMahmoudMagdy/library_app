import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/presentation/bloc/books_bloc.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  AddBookPageState createState() => AddBookPageState();
}

class AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<BooksBloc>(context),
      listener: (context, state) {
        if (state is ErrorState) {
          _showSnackBar(context, "Error while adding new Book");
        } else if (state is DoneState) {
          _showSnackBar(context, "Done added new Book to database");
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add new Book'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Book ID'),
                    keyboardType: TextInputType.number,
                    controller: idController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Book id';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Book Title'),
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Book Title';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      _onSaveClicked(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _onSaveClicked(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSaveClicked(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
    BlocProvider.of<BooksBloc>(context).add(AddBookEvent(BookModel(
      id: int.parse(idController.value.text),
      title: titleController.value.text,
    )));
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
