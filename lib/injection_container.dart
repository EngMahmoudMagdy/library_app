import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/core/network/network_info.dart';
import 'package:library_app/features/book_storing/data/datasourses/library_local_data_source.dart';
import 'package:library_app/features/book_storing/data/datasourses/library_remote_data_source.dart';
import 'package:library_app/features/book_storing/data/repositories/books_repo_impl.dart';
import 'package:library_app/features/book_storing/domain/repositories/books_repo.dart';
import 'package:library_app/features/book_storing/domain/usecases/add_book_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/delete_book_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/get_all_books_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/get_book_by_id_usecase.dart';
import 'package:library_app/features/book_storing/domain/usecases/update_book_usecase.dart';
import 'package:library_app/features/book_storing/presentation/bloc/books_bloc.dart';
import 'package:sqflite/sqflite.dart';

final di = GetIt.instance;

Future<void> init(Database database) async {
  di.registerFactory(() => BooksBloc(
      addBookUseCase: di(),
      deleteBookUseCase: di(),
      getAllBooksUseCase: di(),
      getBookByIdUseCase: di(),
      updateBookUseCase: di()));
  di.registerLazySingleton(() => AddBookUseCase(booksRepo: di()));
  di.registerLazySingleton(() => DeleteBookUseCase(booksRepo: di()));
  di.registerLazySingleton(() => UpdateBookUseCase(booksRepo: di()));
  di.registerLazySingleton(() => GetAllBooksUseCase(booksRepo: di()));
  di.registerLazySingleton(() => GetBookByIdUseCase(booksRepo: di()));

  di.registerLazySingleton<BooksRepo>(() => BooksRepoImpl(
        libraryLocalDataSource: di(),
        libraryRemoteDataSource: di(),
        networkInfo: di(),
      ));

  di.registerLazySingleton(() => http.Client());

  di.registerLazySingleton(() => DataConnectionChecker());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

  di.registerLazySingleton<LibraryLocalDataSource>(
      () => LibraryLocalDataSourceImpl(database: database));
  di.registerLazySingleton<LibraryRemoteDataSource>(
      () => LibraryRemoteDataSourceImpl(client: di()));
}
