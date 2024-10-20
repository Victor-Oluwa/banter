import 'dart:developer';

import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/auth_manager/presentation/view/login.dart';
import 'package:banter/src/note_manager/presentation/view/note_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AuthGlobalListener {
  void authBlocListener({
    required BuildContext context,
    required AuthState state,
    required WidgetRef ref,
  }) {
    log('Auth state: $state');
    // Handling of different state transitions
    if (state is UserLoggedOut) {
      Get.offAll(()=> const LoginView());
    } else if (state is UserLoggedIn) {
      context.read<AuthBloc>().add(SetUserEvent(state.user));
      log('User: ${state.user}');
    } else if (state is UserSet) {
      log('User logged in');
      Get.offAll(() => const NoteView());
    } else if (state is AuthError) {
      log('An error occurred: ${state.message}');
    } else if (state is UserRegistered) {
      log('User registered: ${state.user}');
      Get.to(() => const LoginView());
    }
  }

}
