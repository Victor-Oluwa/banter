import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';

class VerifyUser extends UsecaseWithParams<UserEntity, VerifyUserParams> {
  final AuthRepo authRepo;

  VerifyUser(this.authRepo);

  @override
  FutureResult<UserEntity> call(VerifyUserParams param)async {
   return await authRepo.verifyUser(
      accessToken: param.accessToken,
      refreshToken: param.refreshToken,
    );
  }
}

class VerifyUserParams extends Equatable {
  final String accessToken;
  final String refreshToken;

  const VerifyUserParams({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<String> get props => [accessToken, refreshToken];
}
