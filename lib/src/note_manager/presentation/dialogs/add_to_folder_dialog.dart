import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/dialogs/create_folder_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void showAddToBoxDialog({
  required double width,
  required double height,
  required List<FolderEntity> folders,
  required NoteEntity note,
  required int counter,
  required BuildContext context,
  required TextEditingController folderNameController,
}) {
  Get.dialog(
    Dialog(
      backgroundColor: BanterColors.cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.06, vertical: height * 0.02),
        child: folders.length > 10
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BanterTextWidget(
                    text: 'Choose Box',
                    size: width * 0.07,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.30,
                    child: Scrollbar(
                      child: ListView.separated(
                        itemCount: folders.length,
                        itemBuilder: (context, index) {
                          final folder = folders[index];
                          return InkWell(
                            onTap: () {
                              context.read<NoteManagerBloc>().add(AddNoteToFolderEvent(
                                  folderId: folder.id, note: note));
                              Get.back();
                            },
                            child: BanterTextWidget(
                              text: folder.folderName,
                              size: width * 0.05,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                      showCreateFolderDialog(
                          width: width,
                          height: height,
                          context: context,
                          folderNameController: folderNameController,
                          externalFunction: (folderId) {
                            context.read<NoteManagerBloc>().add(AddNoteToFolderEvent(
                                folderId: folderId, note: note));
                          });
                    },
                    child: const BanterTextWidget(text: 'Create box'),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BanterTextWidget(
                    text: 'Choose Box',
                    size: width * 0.06,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      folders.length,
                      (index) {
                        final folder = folders[index];
                        return InkWell(
                          onTap: () {
                            context.read<NoteManagerBloc>().add(AddNoteToFolderEvent(
                                folderId: folder.id, note: note));
                            Get.back();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.folder, color: BanterColors.toolBarGrey,),
                                  SizedBox(width: width*0.02,),
                                  BanterTextWidget(
                                    text: folder.folderName,
                                    size: width * 0.05,
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                      showCreateFolderDialog(
                          width: width,
                          height: height,
                         context: context,
                          folderNameController: folderNameController,
                          externalFunction: (folderId) {
                            context.read<NoteManagerBloc>().add(AddNoteToFolderEvent(
                                folderId: folderId, note: note));
                          });
                    },
                    child: const BanterTextWidget(text: 'Create box'),
                  ),
                ],
              ),
      ),
    ),
  );
}
