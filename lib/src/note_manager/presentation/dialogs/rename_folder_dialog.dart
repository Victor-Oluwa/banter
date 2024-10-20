import 'dart:developer';

import 'package:banter/core/res/color.dart';
import 'package:banter/core/utils/show_dialog.dart';
import 'package:banter/core/widgets/noted_text_field.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void showRenameDialog({
  required BuildContext context,
  required double width,
  required double height,
  required FolderEntity folder,
  required TextEditingController nameController,
}) {
  Get.dialog(
    Dialog(
      backgroundColor: BanterColors.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BanterTextWidget(
              text: 'New Name',
              color: BanterColors.textColor1,
              size: width * 0.06,
            ),
            const SizedBox(height: 20),
            NotedTextField(
              hintText: 'Enter new name',
              controller: nameController,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const BanterTextWidget(text: 'Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: BanterColors.textColor1),
                  onPressed: () {
                    String name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      final newFolder = FolderEntity(
                        folderName: nameController.text,
                        updatedAt: DateTime.now().toIso8601String(),
                        createdAt: folder.createdAt,
                        ownerId: '',
                        id: folder.id,
                      );

                      context.read<NoteManagerBloc>().add(
                        RenameFolderEvent(newFolder),
                      );
                      Get.back();
                    } else {
                      BanterDialog.show(
                          title: 'Error',
                          message: 'Name field cannot be empty,');
                    }
                  },
                  child: const BanterTextWidget(
                    text: 'Save',
                    color: BanterColors.darkBackground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
