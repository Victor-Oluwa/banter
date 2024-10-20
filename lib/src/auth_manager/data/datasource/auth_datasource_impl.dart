import 'dart:convert';
import 'dart:developer';

import 'package:banter/core/error/exception.dart';
import 'package:banter/core/helpers/crypto_helper.dart';
import 'package:banter/core/local_database/hive_boxes.dart';
import 'package:banter/core/providers/user_provider.dart';
import 'package:banter/core/utils/consts.dart';
import 'package:banter/src/auth_manager/data/datasource/auth_datasource.dart';
import 'package:banter/src/auth_manager/data/model/user_model.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final Dio dio;
  final Box<String> accessTokenBox;
  final Box<String> refreshTokenBox;
  final Box<String> userHashBox;
  final Ref ref;

  AuthDatasourceImpl({
    required this.dio,
    required this.ref,
    required this.userHashBox,
    required this.accessTokenBox,
    required this.refreshTokenBox,
  });

  void _storeToken({
    required String accessToken,
    required String refreshToken,
    required String secretKey,
    required String userHash,
  }) {
    final encryptedAccessToken =
        CryptoHelper.encrypt(data: accessToken, secretKey: secretKey);
    final encryptedRefreshToken =
        CryptoHelper.encrypt(data: refreshToken, secretKey: secretKey);

    log('Raw Access token: $accessToken');
    log('Raw Refresh token: $refreshToken');

    log('Encrypted Access Token: $encryptedAccessToken');
    log('Encrypted Refresh Token: $encryptedRefreshToken');
    log('User hash: $userHash');

    accessTokenBox.put('accessToken', encryptedAccessToken);
    refreshTokenBox.put('refreshToken', encryptedRefreshToken);
    userHashBox.put('userHash', userHash);
  }

  @override
  Future<UserModel> logInUser({required UserEntity user}) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final data = jsonEncode({
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
      });

      final response = await dio.post(
        '$kBaseUrl$kLoginUserEndpoint',
        options: Options(
          headers: kHttpHeader,
        ),
        data: data,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthManagerException(
          message: response.data,
          statusCode: response.statusCode ?? 500,
        );
      }

      final accessToken = response.data['token']['access_token'];
      final refreshToken = response.data['token']['refresh_token'];
      final secretKey = response.data['secretKey'].toString();
      final userHash = response.data['hash'].toString();

      log('Is null?: ${response.data}');

      _storeToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
        secretKey: secretKey,
        userHash: userHash,
      );

      return UserModel.fromJson(response.data);
    } on AuthManagerException catch (_) {
      rethrow;
    } on DioException catch (e) {
      final responseData = e.response?.data;
      if (responseData != null) {
        log('res data $responseData');
        throw AuthManagerException(
          message: responseData['message'] != {}
              ? responseData['message'] ?? 'An error occurred'
              : 'An error occurred',
          statusCode: 500,
        );
      } else {
        throw AuthManagerException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw AuthManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<String> logOutUser() async {
    try {
      accessTokenBox.clear();
      refreshTokenBox.clear();
      return 'User logged out';
    } on AuthManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw AuthManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<UserModel> registerUser({required UserEntity user}) async {
    log('Register called');
    try {
      final userModel = UserModel.fromEntity(user);
      final data = jsonEncode({
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
      });

      final response = await dio.post(
        '$kBaseUrl$kRegisterUserEndpoint',
        options: Options(
          headers: kHttpHeader,
        ),
        data: data,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthManagerException(
          message: response.data,
          statusCode: response.statusCode ?? 500,
        );
      }

      return UserModel.fromJson(response.data);
    } on AuthManagerException catch (_) {
      rethrow;
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null) {
        log('Register user error: $responseData');

        throw AuthManagerException(
          statusCode: 500,
          message: responseData['message'] ?? 'An error occurred',
        );
      } else {
        log('Register user error: ${e.message ?? ''}');
        throw const AuthManagerException(
            message: 'An error occurred', statusCode: 500);
      }
    } catch (e) {
      throw AuthManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<String> setUser({required UserEntity user}) {
    try {
      ref.read(userProvider.notifier).setUser(user);
      return Future.value('User set successfully');
    } on AuthManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw AuthManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserModel> verifyUser({
    required String accessToken,
    required String refreshToken,
  }) async {
    log('verifyUser called');

    try {
      final data = jsonEncode({
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      });

      final response = await dio.post(
        '$kBaseUrl$kVerifyUserEndpoint',
        options: Options(headers: kHttpHeader),
        data: data,
      );

      log('verifyUser res: ${response.data}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthManagerException(
          message: response.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      final String newAccessToken = response.data['tokens']['access_token'];
      final String newRefreshToken = response.data['tokens']['refresh_token'];
      final theSecretKey = response.data['secretKey'] as String;
      final user = response.data['user'];
      final userHash = response.data['hash'];

      _storeToken(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
        secretKey: theSecretKey,
        userHash: userHash,
      );

      final userEntity = UserEntity.fromJson(user);
      return UserModel.fromEntity(userEntity);
    } on AuthManagerException catch (_) {
      rethrow;
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null) {
        throw AuthManagerException(
          message: responseData['message'] ?? 'An error occurred',
          statusCode: 500,
        );
      } else {
        throw AuthManagerException(
          message: e.message ?? 'Unknown Error',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw AuthManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> getSecretKey({required String hash}) async {
    try {
      final data = jsonEncode({
        'hash': hash,
      });

      final response = await dio.post(
        '$kBaseUrl$kGetSecretKeyEndpoint',
        options: Options(headers: kHttpHeader),
        data: data,
      );

      final statusCode = response.statusCode;
      final responseData = response.data;

      if (statusCode != 200 && statusCode != 201) {
        throw AuthManagerException(
            message: responseData, statusCode: statusCode ?? 500);
      }
      return responseData['secretKey'];
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null) {
        throw AuthManagerException(
            message: responseData['message'] ?? 'An error occurred',
            statusCode: 500);
      } else {
        throw AuthManagerException(
            message: e.message ?? 'Unknown error occurred', statusCode: 500);
      }
    } on AuthManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw AuthManagerException(message: e.toString(), statusCode: 500);
    }
  }
}

const kRegisterUserEndpoint = '/register';
const kLoginUserEndpoint = '/login';
const kLogOutUserEndpoint = '/logout';
const kVerifyUserEndpoint = '/verify-user';
const kGetSecretKeyEndpoint = '/get-secrete-key';
