import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/core/error/failures.dart';
import 'package:library_app/core/usecases/usecase.dart';
import 'package:library_app/features/book_storing/domain/repositories/books_repo.dart';

class GetAllBooksUseCase implements UseCase<void, NoParams> {
  final BooksRepo booksRepo;

  GetAllBooksUseCase({required this.booksRepo});

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return booksRepo.getAllBooks();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
