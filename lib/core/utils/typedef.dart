
import 'package:banter/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef DoubleResult<T> = Either<T, String>;
typedef StringMap = Map<String, dynamic>;
typedef IntMap = Map<int, dynamic>;
typedef ResultData<T> = Either<Failure, T>;