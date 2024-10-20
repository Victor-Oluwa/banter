import 'package:banter/core/local_database/hive_boxes.dart';
import 'package:banter/src/auth_manager/data/datasource/auth_datasource.dart';
import 'package:banter/src/auth_manager/data/datasource/auth_datasource_impl.dart';
import 'package:banter/src/auth_manager/data/repo/auth_repo_impl.dart';
import 'package:banter/src/auth_manager/domain/repo/auth_repo.dart';
import 'package:banter/src/auth_manager/domain/use_case/get_secret_key.dart';
import 'package:banter/src/auth_manager/domain/use_case/log_in_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/log_out_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/register_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/set_user.dart';
import 'package:banter/src/auth_manager/domain/use_case/verify_user.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final authBlocProvider = Provider.autoDispose<AuthBloc>(
  (ref) => AuthBloc(
    registerUser: ref.read(registerUserProvider),
    logInUser: ref.read(loginUserProvider),
    logOutUser: ref.read(logOutUserProvider),
    verifyUser: ref.read(verifyUserProvider),
    getSecretKey: ref.read(getSecretKeyProvider),
    setUser: ref.read(setUserProvider),
  ),
);

final authDatasourceProvider = Provider.autoDispose<AuthDatasource>(
  (ref) => AuthDatasourceImpl(
    dio: Dio(),
    ref: ref,
    accessTokenBox: HiveBoxes.accessTokenBox,
    refreshTokenBox: HiveBoxes.refreshTokenBox,
    userHashBox: HiveBoxes.userHashBox,
  ),
);

final authRepoProvider = Provider.autoDispose<AuthRepo>(
  (ref) => AuthRepoImpl(
    ref.read(authDatasourceProvider),
  ),
);

final registerUserProvider = Provider.autoDispose<RegisterUser>(
  (ref) => RegisterUser(
    ref.read(authRepoProvider),
  ),
);

final loginUserProvider = Provider.autoDispose<LogInUser>(
  (ref) => LogInUser(
    ref.read(authRepoProvider),
  ),
);

final logOutUserProvider = Provider.autoDispose<LogOutUser>(
  (ref) => LogOutUser(
    ref.read(authRepoProvider),
  ),
);

final setUserProvider = Provider.autoDispose<SetUser>(
  (ref) => SetUser(
    ref.read(authRepoProvider),
  ),
);

final verifyUserProvider = Provider.autoDispose<VerifyUser>(
  (ref) => VerifyUser(
    ref.read(authRepoProvider),
  ),
);

final getSecretKeyProvider = Provider.autoDispose<GetSecretKey>(
  (ref) => GetSecretKey(
    ref.read(authRepoProvider),
  ),
);
