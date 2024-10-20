import 'package:banter/src/auth_manager/data/model/user_model.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';

abstract class AuthDatasource {
  Future<UserModel> registerUser({required UserEntity user});

  Future<UserModel> logInUser({required UserEntity user});

  Future<String> logOutUser();

  Future<String> setUser({required UserEntity user});

  Future<UserEntity> verifyUser({
    required String accessToken,
    required String refreshToken,
  });

  Future<String>getSecretKey({required String hash});

}
