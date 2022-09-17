import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/core/error/failures.dart';
import 'package:library_app/core/usecases/usecase.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/domain/repositories/books_repo.dart';

class UpdateBookUseCase implements UseCase<void, Params> {
  final BooksRepo booksRepo;

  UpdateBookUseCase({required this.booksRepo});

  @override
  Future<Either<Failure, void>> call(Params params) {
    return booksRepo.updateBook(params.bookModel);
  }
}

class Params extends Equatable {
  final BookModel bookModel;

  const Params({required this.bookModel});

  @override
  List<Object?> get props => [bookModel.id, bookModel.title];
}
