import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/utils/constants.dart';
import 'package:library_app/features/book_storing/presentation/bloc/books_bloc.dart';
import 'package:library_app/features/book_storing/presentation/pages/home_page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), databaseName),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT)',
      );
    },
    version: 1,
  );
  await di.init(await database);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return di.di<BooksBloc>();
      },
      child: MaterialApp(
          title: appTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, widget) {
            return FutureBuilder(
                future: di.di.allReady(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return widget ?? const HomePage();
                  } else {
                    return const HomePage();
                  }
                });
          }),
    );
  }
}
