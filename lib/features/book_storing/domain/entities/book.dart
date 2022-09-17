import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Book extends Equatable {
  final int id;
  final String title;

  Book({
    required this.id,
    required this.title,
  });

  @override
  List<Object> get props => [id, title];
}
