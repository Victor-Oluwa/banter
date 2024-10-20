import 'package:banter/core/error/exception.dart';
import 'package:banter/core/error/failure.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/data/datasource/auth_datasource.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDatasource datasource;

  AuthRepoImpl(this.datasource);

  @override
  FutureResult<UserEntity> logInUser({required UserEntity user}) async {
    try {
      final result = await datasource.logInUser(user: user);
      return Right(result);
    } on AuthManagerException catch (e) {
      return Left(AuthManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> logOutUser() async {
    try {
      final result = await datasource.logOutUser();
      return Right(result);
    } on AuthManagerException catch (e) {
      return Left(AuthManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<UserEntity> registerUser({required UserEntity user}) async {
    try {
      final result = await datasource.registerUser(user: user);
      return Right(result);
    } on AuthManagerException catch (e) {
      return Left(AuthManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> setUser({required UserEntity user}) async {
    try {
      final result = await datasource.setUser(user: user);
      return Right(result);
    } on AuthManagerException catch (e) {
      return Left(AuthManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<UserEntity> verifyUser({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final result = await datasource.verifyUser(
          accessToken: accessToken, refreshToken: refreshToken);
      return Right(result);
    } on AuthManagerException catch (e) {
      return Left(AuthManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> getSecretKey({required String hash})async {
   try{
     final result = await datasource.getSecretKey(hash: hash);
     return Right(result);
   } on AuthManagerException catch (e){
     return Left(AuthManagerFailure.fromException(e));
   }
  }
}
