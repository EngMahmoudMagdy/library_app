import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  static const List _properties =  <dynamic>[];
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure([List? properties = _properties]);

  @override
  List<Object> get props => [_properties];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([List? properties]) : super(properties);
}

class CacheFailure extends Failure {
  const CacheFailure([List? properties]) : super(properties);
}
