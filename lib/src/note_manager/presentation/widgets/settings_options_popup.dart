import 'dart:developer';

import 'package:banter/core/local_database/hive_boxes.dart';
import 'package:banter/core/providers/notes_providers.dart';
import 'package:banter/core/providers/state_providers/state_providers.dart';
import 'package:banter/core/utils/show_dialog.dart';
import 'package:banter/main.dart';
import 'package:banter/src/auth_manager/domain/entity/user_entity.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/auth_manager/presentation/view/login.dart';
import 'package:banter/src/note_manager/presentation/animations/welcome_animation.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';

class SettingsOptionsPopUp extends ConsumerWidget {
  const SettingsOptionsPopUp({
    required this.ref,
    required this.user,
    required this.rotationController,
    required this.noteManagerBloc,
    required this.authenticationBloc,
    required this.welcomeAnimation,
    super.key,
  });

  final UserEntity user;
  final WidgetRef ref;
  final AnimationController rotationController;
  final NoteManagerBloc noteManagerBloc;
  final AuthBloc authenticationBloc;
  final WelcomeAnimation welcomeAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(syncPage);
    final isSyncing = ref.watch(isSyncingProvider);
    final notes =
        ref.watch(noteProvider).where((note) => note.updated == true).toList();
    final deletedNotes = HiveBoxes.deletedNotesBox.values.toList();

    return PopupMenuButton<int>(
        tooltip: 'Settings',
        color: BanterColors.cardColor,
        iconColor: BanterColors.textColor1,
        onSelected: ref.watch(isSyncingProvider) == true
            ? (value) {
                BanterDialog.show(
                    title: 'Hold on', message: 'Syncing is in progress');
                return;
              }
            : (value) {
                if (value == 0) {
                  if (user.id.isEmpty) {
                    Get.to(const LoginView());
                    return;
                  }

                  final lastSyncTime =
                      HiveBoxes.lastSyncTimeBox.get('lastSyncTime');
                  ref.read(isSyncingProvider.notifier).state = true;

                  for (int i = 0; i < deletedNotes.length; i++) {
                    notes.add(deletedNotes[i]);
                  }
                  log('${notes.length} notes was passed');

                  BanterDialog.show(
                      title: 'Update', message: 'Syncing started');
                  rotationController.repeat();
                  Future.delayed(const Duration(seconds: 10), () {
                    noteManagerBloc.add(
                      SyncNotesEvent(
                        notes: notes,
                        userId: user.id,
                        lastSyncTime: lastSyncTime,
                        page: page,
                        limit: 30,
                      ),
                    );
                  });

                  ref.watch(syncPage.notifier).state += 1;
                } else if (value == 1) {
                  log('log out tapped');
                  if (user.id.isEmpty) {
                    // Get.to(() => const LoginView());
                    log('log out tapped 1');

                    authenticationBloc.add(const LogOutUserEvent('Logged out'));
                  } else {
                    log('log out tapped 2');

                    authenticationBloc.add(const LogOutUserEvent('Logged out'));
                  }
                }
              },
        itemBuilder: (context) {
          return <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(
              value: 0,
              child: BanterTextWidget(text: 'Sync notes'),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: BanterTextWidget(
                  text: user.id.isEmpty ? 'Sign in' : 'Log out'),
            ),
          ];
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
          child: RotationTransition(
            turns: welcomeAnimation.rotate,
            child: RotationTransition(
              turns: welcomeAnimation.rotate,
              child: Icon(
                Icons.settings,
                color: BanterColors.textColor1,
              ),
            ),
          ),
        ));
  }
}
