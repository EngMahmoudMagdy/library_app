import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:library_app/core/utils/constants.dart';
import 'package:library_app/features/book_storing/data/models/book_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class LibraryRemoteDataSource {
  Future<void> addBook(BookModel bookModel);

  Future<void> updateBook(BookModel bookModel);

  Future<BookModel> getBookById(int id);

  Future<void> deleteBookById(int id);

  Future<List<BookModel>> getAllBooks();
}

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final http.Client client;

  LibraryRemoteDataSourceImpl({required this.client});

  @override
  Future<BookModel> getBookById(int id) async {
    final response = await client.get(
      Uri.https(baseURL, '/books/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return BookModel.fromMap(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<BookModel>> getAllBooks() async {
    final response = await client.get(
      Uri.https(baseURL, booksPath),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => BookModel.fromMap(e))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> addBook(BookModel bookModel) async {
    final response = await client.post(
      Uri.https(baseURL, booksPath),
      body: bookModel.toMap(),
    );

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateBook(BookModel bookModel) async {
    final response = await client.put(
      Uri.https(baseURL, '/books/${bookModel.id}'),
      body: bookModel.toMap(),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteBookById(int id) async {
    final response = await client.delete(
      Uri.https(baseURL, '/books/$id'),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}
