import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';

class GetSecretKey extends UsecaseWithParams<String, String>{
  final AuthRepo authRepo;
   GetSecretKey(this.authRepo);

  @override
  FutureResult<String> call(String param) async{
   return await authRepo.getSecretKey(hash: param);
  }
}