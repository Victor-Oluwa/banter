import 'package:banter/core/providers/folder_provider.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/dialogs/add_to_folder_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class NoteCard extends ConsumerStatefulWidget {
  const NoteCard({
    super.key,
    required this.height,
    required this.width,
    required this.note,
    required this.folder,
  });

  final double height;
  final double width;
  final NoteEntity note;
  final FolderEntity? folder;

  @override
  ConsumerState<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends ConsumerState<NoteCard> {
  late TextEditingController folderNameController;
  final portalController = OverlayPortalController();
@override
  void initState() {
    folderNameController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    folderNameController.dispose();
    super.dispose();
  }

  String formattedDate(String date){
    final dateTime = DateTime.parse(date);

    return DateFormat('yy-MM-dd - kk:mm:ss').format(dateTime);
  }

  String _getSubText(){
  final noteBody = widget.note.body;
  for(var block in noteBody){
    if(block.containsKey('insert')){
      return block['insert'].toString().split('/n').first;
    }
  }
  return '';

  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        _buildNoteCard(context),
        _buildMoreOptions(),
      ],
    );
  }

  Widget _buildNoteCard(BuildContext context) {
    return SizedBox(
      height: widget.height * 0.15,
      width: widget.width,
      child: Card(
        color: BanterColors.cardColor,
        margin: EdgeInsets.only(bottom: widget.height * 0.02),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(widget.width * 0.10),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildNoteDetails(),
              _buildNoteDate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteDetails() {
    return SizedBox(
      width: widget.width*0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BanterTextWidget(
            overflow: TextOverflow.ellipsis,
            text: widget.note.title,
            size: widget.width * 0.06,
          ),
           BanterTextWidget(
             size: widget.width * 0.04,
             overflow: TextOverflow.ellipsis,
            text: _getSubText(),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildNoteDate() {
    return SizedBox(
      width: widget.width * 0.36,
      child: BanterTextWidget(
        overflow: TextOverflow.ellipsis,
        text:  formattedDate(widget.note.updatedAt),
        size: widget.width * 0.04,
      ),
    );
  }

  Widget _buildMoreOptions() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          portalController.toggle();
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
                Icons.more_vert_rounded,
                color: BanterColors.textColor1,
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
      width: widget.width * 0.65,
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
              _buildAddToBoxOption(),
              if (widget.folder != null) const Divider(),
              if (widget.folder != null) _buildRemoveFromFolderOption(),
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
          DeleteNoteEvent(widget.note.id),
        );
        portalController.hide();
      },
      icon: Wrap(
        children: [
          Icon(
            Icons.delete_outline_rounded,
            color: BanterColors.textColor1,
          ),
          SizedBox(width: widget.width * 0.02),
          const BanterTextWidget(text: 'Delete'),
        ],
      ),
    );
  }

  Widget _buildAddToBoxOption() {
    return IconButton(
      onPressed: () {
        portalController.hide();
        showAddToBoxDialog(
          context: context,
          folderNameController: folderNameController,
          note: widget.note,
          folders: ref.read(folderProvider),
          height: widget.height,
          width: widget.width,
          counter: 11,
        );
      },
      icon: Wrap(
        children: [
          Icon(
            Icons.add_circle_outline,
            color: BanterColors.textColor1,
          ),
          SizedBox(width: widget.width * 0.02),
          BanterTextWidget(text: 'Add to box'),
        ],
      ),
    );
  }

  Widget _buildRemoveFromFolderOption() {
    return IconButton(
      onPressed: () {
        portalController.hide();
        context.read<NoteManagerBloc>().add(
          RemoveNoteFromFolderEvent(
            folderId: widget.folder?.id??'',
            note: widget.note,
          ),
        );
      },
      icon: Wrap(
        children: [
          Icon(
            Icons.remove_circle_outline,
            color: BanterColors.textColor1,
          ),
          SizedBox(width: widget.width * 0.02),
          BanterTextWidget(text: 'Remove from box'),
        ],
      ),
    );
  }
}
