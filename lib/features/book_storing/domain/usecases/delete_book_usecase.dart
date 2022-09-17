import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/core/error/failures.dart';
import 'package:library_app/core/usecases/usecase.dart';
import 'package:library_app/features/book_storing/domain/repositories/books_repo.dart';

class DeleteBookUseCase implements UseCase<void, Params> {
  final BooksRepo booksRepo;

  DeleteBookUseCase({required this.booksRepo});

  @override
  Future<Either<Failure, void>> call(Params params) {
    return booksRepo.deleteBookById(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
