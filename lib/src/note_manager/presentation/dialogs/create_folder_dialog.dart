import 'dart:developer';

import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_field.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void showCreateFolderDialog({
  required double width,
  required double height,
  Function(String)? externalFunction,
  required BuildContext context,
  required TextEditingController folderNameController,
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
              text: 'Name Box',
              color: BanterColors.textColor1,
              size: width * 0.06,
            ),
            SizedBox(height: 20),
            NotedTextField(
              hintText: 'Enter box name',
              controller: folderNameController,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: BanterTextWidget(text: 'Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: BanterColors.textColor1),
                  onPressed: () {
                    String name = folderNameController.text.trim();
                    if (name.isNotEmpty) {
                      final uniqueId = UniqueKey().toString();
                      final folder = FolderEntity(
                        folderName: folderNameController.text,
                        createdAt: DateTime.now().toIso8601String(),
                        updatedAt: DateTime.now().toIso8601String(),
                        ownerId: '',
                        id: uniqueId,
                      );

                      context.read<NoteManagerBloc>().add(CreateFolderEvent(folder));
                      externalFunction?.call(uniqueId);
                      Get.back();
                    } else {
                      Get.snackbar(
                        'Error',
                        'Name cannot be empty!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: BanterColors.darkTunnel,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: BanterTextWidget(
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
