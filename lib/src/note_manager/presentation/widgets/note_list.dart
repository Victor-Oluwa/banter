
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/view/create_note_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/widgets/note_card.dart';


class NoteList extends StatelessWidget {
  final List<NoteEntity> notes;
  final double height;
  final double width;
  final FolderEntity? folder;

  const NoteList({
    super.key,
    required this.notes,
    required this.height,
    required this.width,
    required this.folder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        notes.length,
            (index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () {
              if (folder == null) {
                Get.to(() => const CreateNoteView(), arguments: note);
              } else {
                Get.to(() => const CreateNoteView(), arguments: {
                  'note': note,
                  'folderId': folder?.id,
                });
              }
            },
            child: NoteCard(
              height: height,
              width: width,
              note: note,
              folder: folder,
            ),
          );
        },
      ),
    );
  }
}