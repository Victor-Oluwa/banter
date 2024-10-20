import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';

class SetUser extends UsecaseWithParams<String, UserEntity>{
  final AuthRepo authRepo;

  SetUser(this.authRepo);

  @override
  FutureResult<String> call(UserEntity param) async{
    return await authRepo.setUser(user: param);
  }
}