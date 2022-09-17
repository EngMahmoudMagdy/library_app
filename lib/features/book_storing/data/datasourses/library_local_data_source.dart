import 'package:library_app/core/utils/constants.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/error/exceptions.dart';

abstract class LibraryLocalDataSource {
  Future<void> cacheBook(BookModel bookToCache);

  Future<void> cacheBooks(List<BookModel> bookToCache);

  Future<void> deleteBook(int bookId);

  Future<BookModel> getBookById(int bookId);

  Future<List<BookModel>> getBooks();

  Future<void> updateBook(BookModel bookModel);
}

class LibraryLocalDataSourceImpl implements LibraryLocalDataSource {
  final Database database;

  LibraryLocalDataSourceImpl({required this.database});

  @override
  Future<List<BookModel>> getBooks() async {
    final List<Map<String, dynamic>> list = await database.query(tableBook);
    if (list.isNotEmpty) {
      return Future.value(list.map((e) => BookModel.fromMap(e)).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBook(BookModel bookToCache) {
    return database.insert(tableBook, bookToCache.toMap());
  }

  @override
  Future<void> deleteBook(int bookId) {
    return database.delete(tableBook, where: "id = $bookId");
  }

  @override
  Future<void> cacheBooks(List<BookModel> bookToCache) {
    Batch batch = database.batch();
    bookToCache.forEach((element) {
      batch.insert(tableBook, element.toMap());
    });
    return batch.commit();
  }

  @override
  Future<BookModel> getBookById(int bookId) async {
    final List<Map<String, dynamic>> list =
        await database.query(tableBook, where: "id = $bookId");
    if (list.isNotEmpty) {
      return Future.value(list.map((e) => BookModel.fromMap(e)).toList().first);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> updateBook(BookModel bookModel) {
    return database.update(tableBook, bookModel.toMap(),
        where: "id = ${bookModel.id}");
  }
}
