import 'package:equatable/equatable.dart';

class NoteManagerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const NoteManagerException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<dynamic> get props => [message, statusCode];
}

class AuthManagerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

 const AuthManagerException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<dynamic> get props => [message, statusCode];
}
