import 'package:banter/core/error/exception.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;

  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(statusCode is String || statusCode is int,
            'StatusCode cannot be of type ${statusCode.runtimeType}');

  String get errorMessage => message;

  @override
  List<dynamic> get props => [message, statusCode];
}

class NoteManagerFailure extends Failure {
  NoteManagerFailure({
    required super.message,
    required super.statusCode,
  });

  NoteManagerFailure.fromException(NoteManagerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );

  @override
  List<dynamic> get props => [message, statusCode];
}

class AuthManagerFailure extends Failure {
  AuthManagerFailure({
    required super.message,
    required super.statusCode,
  });

  AuthManagerFailure.fromException(AuthManagerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );

  @override
  List<dynamic> get props => [message, statusCode];
}
