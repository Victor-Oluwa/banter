import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';

class RegisterUser extends UsecaseWithParams<UserEntity, UserEntity>{
  final AuthRepo repo;
   RegisterUser(this.repo);

  @override
  FutureResult<UserEntity> call(UserEntity param)async {
   return await repo.registerUser(user: param);
  }
}