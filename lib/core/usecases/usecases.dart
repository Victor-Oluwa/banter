import 'package:banter/core/utils/typedef.dart';

abstract class UsecaseWithParams<Type, Param> {
  UsecaseWithParams();

  FutureResult<Type> call(Param param);
}

abstract class UseCaseWithoutParams<Type> {
  UseCaseWithoutParams();

  FutureResult<Type> call();
}

abstract class NonFutureUseCaseWithoutParams<Type> {
  NonFutureUseCaseWithoutParams();
  Type call();
}




















