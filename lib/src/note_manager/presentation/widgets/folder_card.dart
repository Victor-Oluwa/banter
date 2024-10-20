import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/dialogs/rename_folder_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderCard extends StatefulWidget {
  const FolderCard({
    super.key,
    required this.width,
    required this.folder,
    required this.height,
    required this.context,
    required this.notes,
  });

  final double width;
  final FolderEntity folder;
  final double height;
  final BuildContext context;
  final List<NoteEntity> notes;

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  final portalController = OverlayPortalController();
  late TextEditingController renameFolderController;

  get getNoteCount => widget.notes
      .where((note) => note.folderIds.contains(widget.folder.id))
      .toList()
      .length
      .toString();

  @override
  void initState() {
    renameFolderController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    renameFolderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFolderCard(),
        _buildMoreOption(),
      ],
    );
  }

  Widget _buildMoreOption() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          portalController.show();
        },
        child: Padding(
          padding: EdgeInsets.all(widget.width * 0.03),
          child: SizedBox(
            height: widget.height * 0.05,
            width: widget.width * 0.05,
            child: OverlayPortal(
              controller: portalController,
              overlayChildBuilder: _buildOverlayMenu,
              child: Icon(
                color: BanterColors.textColor1,
                Icons.more_vert_rounded,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayMenu(BuildContext context) {
    return GestureDetector(
      onTap: () {
        portalController.hide();
      },
      child: Card(
        color: Colors.blueGrey.shade900.withOpacity(0.1),
        child: Column(
          children: [
            _buildCloseButton(),
            const Spacer(),
            _buildMenuOptions(),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: widget.width * 0.05,
          top: widget.height * 0.07,
        ),
        child: IconButton(
          onPressed: () {
            portalController.hide();
          },
          icon: Icon(
            size: widget.width * 0.08,
            Icons.cancel,
            color: BanterColors.textColor1,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOptions() {
    return SizedBox(
      width: widget.width * 0.60,
      child: Card(
        elevation: 0,
        color: BanterColors.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeleteOption(),
              const Divider(),
              _buildRenameOption(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteOption() {
    return IconButton(
      onPressed: () {
        context.read<NoteManagerBloc>().add(
          DeleteFolderEvent(widget.folder.id),
        );
        portalController.hide();
      },
      icon: Wrap(
        children: [
          const Icon(
            Icons.delete_outline,
            color: BanterColors.textColor1,
          ),
          SizedBox(width: widget.width * 0.02),
          const BanterTextWidget(text: 'Delete'),
        ],
      ),
    );
  }

  Widget _buildRenameOption() {
    return IconButton(
      onPressed: () {
        portalController.hide();
        showRenameDialog(
          width: widget.width,
          height: widget.height,
          context:context,
          folder: widget.folder,
          nameController: renameFolderController,
        );
      },
      icon: Wrap(
        children: [
          const Icon(
            Icons.edit_note_rounded,
            color: BanterColors.textColor1,
          ),
          SizedBox(width: widget.width * 0.02),
          const BanterTextWidget(text: 'Rename'),
        ],
      ),
    );
  }

  SizedBox buildFolderCard() {
    return SizedBox(
      width: widget.width,
      height: widget.height * 0.13,
      child: Card(
        elevation: 0,
        color: BanterColors.cardColor,
        child: Padding(
          padding: EdgeInsets.all(widget.width * 0.04),
          child: Row(
            children: [
              Icon(
                Icons.folder_open,
                color: BanterColors.toolBarGrey,
                size: widget.width * 0.12,
              ),
              SizedBox(
                width: widget.width * 0.03,
              ),
              SizedBox(
                width: widget.width * 0.60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BanterTextWidget(
                      text: widget.folder.folderName,
                      size: widget.width * 0.05,
                      overflow: TextOverflow.ellipsis,
                    ),
                    BanterTextWidget(
                      overflow: TextOverflow.ellipsis,
                      text: '$getNoteCount notes',
                      size: widget.width * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
