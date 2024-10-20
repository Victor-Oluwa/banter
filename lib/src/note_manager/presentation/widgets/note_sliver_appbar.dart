
import 'package:banter/core/providers/user_provider.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/note_manager/presentation/animations/welcome_animation.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/widgets/search_field.dart';
import 'package:banter/src/note_manager/presentation/widgets/settings_options_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/view/folder_view.dart';
import 'package:banter/src/note_manager/presentation/widgets/switcher.dart';

class NoteSliverAppbar extends StatelessWidget {
  final double height;
  final double width;
  final WidgetRef ref;
  final FolderEntity? folder;
  final TextEditingController searchController;
  final AnimationController rotationController;
  final NoteManagerBloc noteManagerBloc;
  final AuthBloc authenticationBloc;
  final WelcomeAnimation welcomeAnimation;

  const NoteSliverAppbar({
    super.key,
    required this.height,
    required this.width,
    required this.ref,
    required this.folder,
    required this.searchController,
    required this.rotationController,
    required this.noteManagerBloc,
    required this.welcomeAnimation,
    required this.authenticationBloc,
  });

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: height * 0.27,
      actions: [
        SettingsOptionsPopUp(
          authenticationBloc: authenticationBloc,
          welcomeAnimation: welcomeAnimation,
          noteManagerBloc: noteManagerBloc,
          user: user,
          rotationController: rotationController,
          ref: ref,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SlideTransition(
          position: welcomeAnimation.slideFromRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.10),
              BanterTextWidget(
                text: folder == null
                    ? 'Your Notes'
                    : folder?.folderName ?? 'Your Notes',
                size: width * 0.10,
                color: BanterColors.textColor1,
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  InkWell(
                    splashColor: BanterColors.tunnel,
                    onTap: () {
                      Get.offAll(() => const FolderView(), transition: Transition.fadeIn);
                    },
                    child: Switcher(
                      height: height,
                      width: width,
                      icon: Icons.folder_open,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  SearchField(width: width, searchController: searchController),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

