import 'dart:developer';

import 'package:banter/core/helpers/crypto_helper.dart';
import 'package:banter/core/local_database/hive_boxes.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/utils/show_dialog.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/note_manager/presentation/view/note_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// for Socket
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final accessTokenBox = HiveBoxes.accessTokenBox;
  final refreshTokenBox = HiveBoxes.refreshTokenBox;
  final hashBox = HiveBoxes.userHashBox;
  late AuthBloc authBloc;

  @override
  void initState() {
    _getSecretKey();
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

  _getSecretKey() async {
    final userHash = hashBox.get('userHash') ?? '';
    final accessToken = accessTokenBox.get('accessToken') ?? '';
    final refreshToken = refreshTokenBox.get('refreshToken') ?? '';

    final hasInternet = await checkInternetAccess();

    log('Internet: $hasInternet');

    if (userHash.isEmpty ||
        accessToken.isEmpty ||
        refreshToken.isEmpty ||
        !hasInternet) {
      log('Going to note view..');

      Future.delayed(const Duration(seconds: 2), (){
        Get.offAll(() => const NoteView());
      });
      return;
    }
    authBloc.add(GetSecretKeyEvent(userHash));
  }

  _verifyUser(String secretKey) async {
    log('Verifying...');
    final accessToken = accessTokenBox.get('accessToken') ?? '';
    final refreshToken = refreshTokenBox.get('refreshToken') ?? '';

    final decryptedAccessToken =
    CryptoHelper.decrypt(base64Data: accessToken, secretKey: secretKey);
    final decryptedRefreshToken =
    CryptoHelper.decrypt(base64Data: refreshToken, secretKey: secretKey);
    log('decrypted access token: $decryptedAccessToken');
    log('decrypted refresh token: $decryptedRefreshToken');
    authBloc.add(
      VerifyUserEvent(
          accessToken: decryptedAccessToken,
          refreshToken: decryptedRefreshToken),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: BanterColors.textColor1,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GottenSecretKey) {
            log('Gotten secret key');
            _verifyUser(state.key);
          }

          if (state is UserVerified) {
            BanterDialog.show(title: 'SUCCESS', message: 'User verified!');
            log('user verified: ${state.user.email}');

            authBloc.add(SetUserEvent(state.user));
          }

          if (state is AuthError) {
            log('Error: ${state.message}');

            Future.delayed(const Duration(seconds: 2), (){
              Get.offAll(() => const NoteView());
            });
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height*0.10,),
                Image(
                  height: width * 0.50,
                  image: const AssetImage('assets/Banter_logo.png'),
                ),
                Image(
                    height: width * 0.20,

                    image: const AssetImage('assets/orikix.png'))
              ],
            ),
          );
        },
      ),
    );
  }

  Future<bool> checkInternetAccess() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      // No network connection at all
      return false;
    } else {
      // We have a network connection, now check if we have internet access
      return await hasInternetConnection();
    }
  }

  Future<bool> hasInternetConnection() async {
    try {
      // Try to ping an external URL
      final response = await Dio().get('https://www.google.com');
      // If the response is 200, the device has internet access
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false; // No internet access if the request fails
    }
  }
}
