part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {}

class AddBookEvent extends BooksEvent {
  final BookModel bookModel;

  AddBookEvent(this.bookModel);

  @override
  List<Object> get props => [bookModel];
}

class UpdateBookEvent extends BooksEvent {
  final BookModel bookModel;

  UpdateBookEvent(this.bookModel);

  @override
  List<Object> get props => [bookModel];
}

class DeleteBookEvent extends BooksEvent {
  final int id;

  DeleteBookEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetBookByIdEvent extends BooksEvent {
  final int id;

  GetBookByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetAllBooksEvent extends BooksEvent {
  GetAllBooksEvent();

  @override
  List<Object> get props => [];
}
