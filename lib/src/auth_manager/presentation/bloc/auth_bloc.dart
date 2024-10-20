import 'dart:developer';

import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/domain/use_case/get_secret_key.dart';
import 'package:banter/src/auth_manager/domain/use_case/log_in_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/log_out_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/register_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/set_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/verify_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RegisterUser registerUser,
    required LogInUser logInUser,
    required LogOutUser logOutUser,
    required SetUser setUser,
    required VerifyUser verifyUser,
    required GetSecretKey getSecretKey,
  })  : _registerUser = registerUser,
        _logInUser = logInUser,
        _logOutUser = logOutUser,
        _setUser = setUser,
        _verifyUser = verifyUser,
        _getSecretKey = getSecretKey,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
    });
    on<RegisterUserEvent>(_registerUserEventHandler);
    on<LoginUserEvent>(_logInUserEventHandler);
    on<LogOutUserEvent>(_logOutUserEventHandler);
    on<VerifyUserEvent>(_verifyUserEventHandler);
    on<GetSecretKeyEvent>(_getSecretKeyEventHandler);
    on<SetUserEvent>(_setUserEventHandler);
  }

  final RegisterUser _registerUser;
  final LogInUser _logInUser;
  final LogOutUser _logOutUser;
  final SetUser _setUser;
  final VerifyUser _verifyUser;
  final GetSecretKey _getSecretKey;

  void _registerUserEventHandler(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _registerUser(event.user);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserRegistered(r),
      ),
    );
  }

  void _logInUserEventHandler(
      LoginUserEvent event, Emitter<AuthState> emit) async {
    log('Log in event called');
    final result = await _logInUser(event.user);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserLoggedIn(r),
      ),
    );
  }

  void _logOutUserEventHandler(
    LogOutUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _logOutUser();
log('Event called $result');
    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserLoggedOut(r),
      ),
    );
  }

  void _setUserEventHandler(
    SetUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _setUser(event.user);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserSet(r),
      ),
    );
  }

  void _verifyUserEventHandler(
      VerifyUserEvent event, Emitter<AuthState> emit) async {
    final result = await _verifyUser(
      VerifyUserParams(
          accessToken: event.accessToken, refreshToken: event.refreshToken),
    );

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserVerified(r),
      ),
    );
  }

  void _getSecretKeyEventHandler(
      GetSecretKeyEvent event, Emitter<AuthState> emit) async {
    final result = await _getSecretKey(event.hash);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        GottenSecretKey(r),
      ),
    );
  }
}
