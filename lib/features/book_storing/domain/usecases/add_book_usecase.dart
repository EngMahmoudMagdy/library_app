import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/core/error/failures.dart';
import 'package:library_app/core/usecases/usecase.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/domain/repositories/books_repo.dart';

class AddBookUseCase implements UseCase<void, AddBookParams> {
  final BooksRepo booksRepo;

  AddBookUseCase({required this.booksRepo});

  @override
  Future<Either<Failure, void>> call(AddBookParams params) {
    return booksRepo.addBook(params.bookModel);
  }
}

class AddBookParams extends Equatable {
  final BookModel bookModel;

  const AddBookParams({required this.bookModel});

  @override
  List<Object?> get props => [bookModel.id, bookModel.title];
}
