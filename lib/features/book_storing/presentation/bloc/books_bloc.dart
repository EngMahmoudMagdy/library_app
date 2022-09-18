import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/add_book_usecase.dart';
import '../../domain/usecases/delete_book_usecase.dart';
import '../../domain/usecases/get_all_books_usecase.dart';
import '../../domain/usecases/get_book_by_id_usecase.dart';
import '../../domain/usecases/update_book_usecase.dart';

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
    on<BooksEvent>((event, emit) async {
      if (event is GetAllBooksEvent) {
        emit(LoadingState());
        final values = await getAllBooksUseCase(NoParams());
        values.fold((l) {
          final message = (l is ServerFailure) ? "Server error" : "Cache error";
          emit(ErrorState(message));
        }, (r) {
          emit(AllBooksRetrieveState(r));
        });
      } else if (event is AddBookEvent) {
        emit(LoadingState());
        final result =
            await addBookUseCase(AddBookParams(bookModel: event.bookModel));
        result.fold((l) {
          final message = (l is ServerFailure) ? "Server error" : "Cache error";
          emit(ErrorState(message));
        }, (r) {
          emit(DoneState());
        });
      } else if (event is UpdateBookEvent) {
        emit(LoadingState());
        final result = await updateBookUseCase(
            UpdateBookParams(bookModel: event.bookModel));
        result.fold((l) {
          final message = (l is ServerFailure) ? "Server error" : "Cache error";
          emit(ErrorState(message));
        }, (r) {
          emit(DoneState());
        });
      }
    });
  }
}
