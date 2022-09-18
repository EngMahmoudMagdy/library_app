part of 'books_bloc.dart';

@immutable
abstract class BooksState {}

class BooksInitial extends BooksState {
  @override
  List<Object> get props => [];
}

class LoadingState extends BooksState {
  @override
  List<Object> get props => [];
}

class DoneState extends BooksState {
  @override
  List<Object> get props => [];
}

class EmptyState extends BooksState {
  @override
  List<Object> get props => [];
}

class ErrorState extends BooksState {
  final String message ;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class BookRetrieveState extends BooksState {

  @override
  List<Object> get props => [];
}

class AllBooksRetrieveState extends BooksState {
  final List<BookModel> list;

  AllBooksRetrieveState(this.list);

  @override
  List<Object> get props => [list];
}
