import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';

class LogOutUser extends UseCaseWithoutParams<String>{
  final AuthRepo repo;
  LogOutUser(this.repo);

  @override
  FutureResult<String> call()async {
   return await repo.logOutUser();
  }
}