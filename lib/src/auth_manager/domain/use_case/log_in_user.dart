import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';

class LogInUser extends UsecaseWithParams<UserEntity, UserEntity> {
  final AuthRepo repo;

  LogInUser(this.repo);

  @override
  FutureResult<UserEntity> call(UserEntity param) async {
    return await repo.logInUser(user: param);
  }
}
