import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/view/note_view.dart';
import 'package:banter/src/note_manager/presentation/widgets/folder_card.dart';

class FolderCardItem extends StatelessWidget {
  final FolderEntity folder;
  final List<NoteEntity> notes;
  final double width;
  final double height;
  final BuildContext context;

  const FolderCardItem({
    super.key,
    required this.folder,
    required this.notes,
    required this.width,
    required this.height,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const NoteView(), arguments: folder);
      },
      child: FolderCard(
        width: width,
        folder: folder,
        height: height,
        notes: notes,
        context: context,
      ),
    );
  }
}