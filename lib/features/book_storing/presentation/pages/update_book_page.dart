import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/presentation/bloc/books_bloc.dart';

class UpdateBookPage extends StatefulWidget {
  const UpdateBookPage({Key? key}) : super(key: key);

  @override
  UpdateBookPageState createState() => UpdateBookPageState();
}

class UpdateBookPageState extends State<UpdateBookPage> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookModel = ModalRoute.of(context)!.settings.arguments as BookModel;
    idController.text = bookModel.id.toString();
    titleController.text = bookModel.title.toString();
    return BlocListener(
      bloc: BlocProvider.of<BooksBloc>(context),
      listener: (context, state) {
        if (state is ErrorState) {
          _showSnackBar(context, "Error while adding new Book");
        } else if (state is DoneState) {
          _showSnackBar(context, "Done Updated Book in database");
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
                    decoration: const InputDecoration(hintText: 'Book ID'),
                    keyboardType: TextInputType.number,
                    controller: idController,
                    focusNode: AlwaysDisabledFocusNode(),
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
                    decoration: const InputDecoration(hintText: 'Book Title'),
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
    BlocProvider.of<BooksBloc>(context).add(UpdateBookEvent(BookModel(
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
