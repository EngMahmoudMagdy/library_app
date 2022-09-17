import 'package:library_app/features/book_storing/domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required int id,
    required String title,
  }) : super(
          id: id,
          title: title,
        );

  factory BookModel.fromMap(Map<String, dynamic> json) {
    return BookModel(
      id: (json['id'] as num).toInt(),
      title: json['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  @override
  String toString() {
    return 'BookModel{id:$id,title:$title}';
  }
}
