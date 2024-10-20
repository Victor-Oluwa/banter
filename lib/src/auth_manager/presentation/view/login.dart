import 'dart:developer';

import 'package:banter/core/res/color.dart';
import 'package:banter/core/services/injection/auth_injection.dart';
import 'package:banter/core/widgets/noted_text_field.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/auth_manager/presentation/view/sign_up.dart';
import 'package:banter/src/note_manager/presentation/view/note_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banter/src/auth_manager/presentation/widgets/auth_action_button.dart';
import 'package:get/get.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  late AuthBloc _authBloc;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  getTextFieldProps(String key) {
    Map<String, List> textFieldProps = {
      'controllers': [
        emailController,
        passwordController,
      ],
      'hintTexts': [
        'Enter a email',
        'Enter a password',
      ]
    };

    return textFieldProps[key];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: BanterColors.darkBackground,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Center(
            child: SafeArea(
              child: SizedBox(
                width: width * 0.90,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      BanterTextWidget(
                        text: 'Log In',
                        size: width * 0.15,
                      ),
                      const Spacer(),
                      Form(
                        key: formKey,
                        child: Column(
                          children: List.generate(
                            2,
                            (index) {
                              final controller =
                                  getTextFieldProps('controllers')?[index];
                              final hintText =
                                  getTextFieldProps('hintTexts')?[index];

                              return Padding(
                                padding:
                                    EdgeInsets.only(bottom: height * 0.03),
                                child: NotedTextField(
                                  controller: controller,
                                  hintText: hintText,
                                  validator: (data) {
                                    if (data == null || data.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          AuthActionButton(
                            color: BanterColors.cardColor,
                            text: 'Sign Up',
                            width: width * 0.30,
                            height: height * 0.07,
                            onPressed: () {
                              Get.offAll(() => const SignUpView());
                            },
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Expanded(
                            child: AuthActionButton(
                              color: BanterColors.cardColor,
                              text: 'Log In',
                              width: width * 0.60,
                              height: height * 0.07,
                              onPressed: signIn,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void signIn() {
    final formState = formKey.currentState;
    if (formState != null && formState.validate()) {
      final user = UserEntity(
        id: '',
        name: '',
        email: emailController.text,
        password: passwordController.text,
      );
      // context.read<AuthBloc>().add(LoginUserEvent(user));
      _authBloc.add(LoginUserEvent(user));
    } else {
      log('Form state is null');
    }
  }
}
