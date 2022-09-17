import 'package:dartz/dartz.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';

import '../../../../core/error/failures.dart';

abstract class BooksRepo {
  Future<Either<Failure, BookModel>> getBookById(int id);

  Future<Either<Failure, void>> addBook(BookModel bookModel);

  Future<Either<Failure, void>> updateBook(BookModel bookModel);

  Future<Either<Failure, void>> deleteBookById(int id);

  Future<Either<Failure, List<BookModel>>> getAllBooks();
}
