import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/core/error/failures.dart';
import 'package:library_app/core/usecases/usecase.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/domain/repositories/books_repo.dart';

class UpdateBookUseCase implements UseCase<void, UpdateBookParams> {
  final BooksRepo booksRepo;

  UpdateBookUseCase({required this.booksRepo});

  @override
  Future<Either<Failure, void>> call(UpdateBookParams params) {
    return booksRepo.updateBook(params.bookModel);
  }
}

class UpdateBookParams extends Equatable {
  final BookModel bookModel;

  const UpdateBookParams({required this.bookModel});

  @override
  List<Object?> get props => [bookModel.id, bookModel.title];
}
