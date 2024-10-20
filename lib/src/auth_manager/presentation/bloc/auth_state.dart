part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<String> get props => [message];
}

class UserRegistered extends AuthState {
  final UserEntity user;

  const UserRegistered(this.user);

  @override
  List<UserEntity> get props => [user];
}

class UserLoggedIn extends AuthState {
  final UserEntity user;

  const UserLoggedIn(this.user);

  @override
  List<UserEntity> get props => [user];
}

class UserLoggedOut extends AuthState {
  final String message;

  const UserLoggedOut(this.message);

  @override
  List<String> get props => [message];
}

class UserSet extends AuthState{
  final String message;
 const UserSet(this.message);

  @override
  List<String> get props =>[message];
}

class UserVerified extends AuthState{
  final UserEntity user;

  const UserVerified(this.user);

  @override
  List<UserEntity> get props =>[user];
}

class GottenSecretKey extends AuthState{
  final String key;
  const GottenSecretKey(this.key);

  @override
  List<String> get props=> [key];
}