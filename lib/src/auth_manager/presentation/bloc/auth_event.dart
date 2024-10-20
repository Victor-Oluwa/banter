part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class RegisterUserEvent extends AuthEvent {
  final UserEntity user;

  const RegisterUserEvent(this.user);

  @override
  List<UserEntity> get props => [user];
}

class LoginUserEvent extends AuthEvent {
  final UserEntity user;

  const LoginUserEvent(this.user);

  @override
  List<UserEntity> get props => [user];
}

class LogOutUserEvent extends AuthEvent {
  final String message;

  const LogOutUserEvent(this.message);

  @override
  List<String> get props => [message];
}

class SetUserEvent extends AuthEvent{
  final UserEntity user;
  const SetUserEvent(this.user);

  @override
  List<UserEntity> get props => [user];
}

class VerifyUserEvent extends AuthEvent{
  final String accessToken;
  final String refreshToken;

  const VerifyUserEvent({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<String> get props => [accessToken, refreshToken];
}

class GetSecretKeyEvent extends AuthEvent{
  final String hash;
  const GetSecretKeyEvent(this.hash);

  @override
  List<String> get props => [hash];
}
