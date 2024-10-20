import 'package:banter/core/error/exception.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class ErrorCatcher {
  static DoubleResult<Exception> checkStatusCode(
      {required Response response, required Type exceptionType}) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      if (exceptionType == AuthManagerException) {
        final result = AuthManagerException(
            message: response.data, statusCode: response.statusCode ?? 500);
        return Left(result);
      }else if(exceptionType == NoteManagerException){
      final result = AuthManagerException(
            message: response.data, statusCode: response.statusCode ?? 500);
      return Left(result);
      }else{
       final result =  NoteManagerException(
          message: 'Misplaced exception: ${response.data}',
          statusCode: 500,
        );

       return Left(result);
      }

    }else{
      return const Right('Proceed');
    }
  }

  static Exception catchDioError(
      {required DioException dioException, required Type exceptionType}) {
    final responseData = dioException.response?.data;

    if (exceptionType == AuthManagerException) {
      if (responseData != null) {
        return AuthManagerException(message: responseData['message'] != {}
            ? responseData['message'] ?? 'An error occurred'
            : 'An error occurred', statusCode: 500);
      } else {
        return AuthManagerException(
            message: dioException.message?? 'Unknown error',
            statusCode: 500);
      }
    } else if (exceptionType == NoteManagerException) {
      if (responseData != null) {
        return NoteManagerException(message: responseData['message'] != {}
            ? responseData['message'] ?? 'An error occurred'
            : 'An error occurred', statusCode: 500);
      } else {
        return NoteManagerException(
            message: dioException.message??'Unknown error',
            statusCode: 500);
      }
    } else {
      return NoteManagerException(
        message: 'Misplaced exception: $dioException',
        statusCode: 500,
      );
    }
  }

  static Exception catchGeneralError({
    required Object object,
    required Type exceptionType,
  }) {
    if (exceptionType == AuthManagerException) {
      return AuthManagerException(
        message: object.toString(),
        statusCode: 500,
      );
    } else if (exceptionType == NoteManagerException) {
      return NoteManagerException(
        message: object.toString(),
        statusCode: 500,
      );
    }else{
      return NoteManagerException(
        message: 'Misplaced exception: $object',
        statusCode: 500,
      );
    }
  }
}
