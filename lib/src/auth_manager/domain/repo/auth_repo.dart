import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';

abstract class AuthRepo {
  FutureResult<UserEntity> registerUser({required UserEntity user});

  FutureResult<UserEntity> logInUser({required UserEntity user});

  FutureResult<String> logOutUser();

  FutureResult<String> setUser({required UserEntity user});

  FutureResult<UserEntity> verifyUser({
    required String accessToken,
    required String refreshToken,
  });

  FutureResult<String>getSecretKey({required String hash});

//Check for token
// Check for connection
//NO CONNECTION: Notes else Verify token
}
