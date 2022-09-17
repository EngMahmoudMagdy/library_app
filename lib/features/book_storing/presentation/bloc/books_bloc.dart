import 'package:bloc/bloc.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/domain/usecases/add_book_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/delete_book_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/get_all_books_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/get_book_by_id_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/update_book_usecase.dart';
import 'package:meta/meta.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final AddBookUseCase addBookUseCase;
  final DeleteBookUseCase deleteBookUseCase;
  final GetAllBooksUseCase getAllBooksUseCase;
  final GetBookByIdUseCase getBookByIdUseCase;
  final UpdateBookUseCase updateBookUseCase;

  BooksBloc(
      {required this.addBookUseCase,
      required this.deleteBookUseCase,
      required this.getAllBooksUseCase,
      required this.getBookByIdUseCase,
      required this.updateBookUseCase})
      : super(BooksInitial()) {
    on<BooksEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
