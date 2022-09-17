import 'package:dartz/dartz.dart';
import 'package:library_app/core/error/failures.dart';
import 'package:library_app/features/book_storing/data/datasourses/library_local_data_source.dart';
import 'package:library_app/features/book_storing/data/datasourses/library_remote_data_source.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:library_app/features/book_storing/domain/repositories/books_repo.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class BooksRepoImpl extends BooksRepo {
  final LibraryLocalDataSource libraryLocalDataSource;
  final LibraryRemoteDataSource libraryRemoteDataSource;
  final NetworkInfo networkInfo;

  BooksRepoImpl(
      {required this.libraryLocalDataSource,
      required this.libraryRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, void>> addBook(BookModel bookModel) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await libraryRemoteDataSource.addBook(bookModel);
        await libraryLocalDataSource.cacheBook(bookModel);
        return Right(remoteData);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localData = await libraryLocalDataSource.cacheBook(bookModel);
        return Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteBookById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await libraryRemoteDataSource.deleteBookById(id);
        await libraryLocalDataSource.deleteBook(id);
        return Right(remoteData);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localData = await libraryLocalDataSource.deleteBook(id);
        return Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> getAllBooks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await libraryRemoteDataSource.getAllBooks();
        await libraryLocalDataSource.cacheBooks(remoteData);
        return Right(remoteData);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localData = await libraryLocalDataSource.getBooks();
        return Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, BookModel>> getBookById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await libraryRemoteDataSource.getBookById(id);
        await libraryLocalDataSource.cacheBook(remoteData);
        return Right(remoteData);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localData = await libraryLocalDataSource.getBookById(id);
        return Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateBook(BookModel bookModel) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await libraryRemoteDataSource.updateBook(bookModel);
        await libraryLocalDataSource.updateBook(bookModel);
        return Right(remoteData);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localData = await libraryLocalDataSource.updateBook(bookModel);
        return Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }
}
