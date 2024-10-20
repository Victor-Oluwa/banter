import 'dart:developer';
import 'package:banter/src/note_manager/presentation/utils/text_styles.dart';
import 'package:banter/src/note_manager/presentation/widgets/editor/tool_revealer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as ql;
import 'package:banter/core/res/color.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/core/services/injection/note_manager/note_manager_injection.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/core/widgets/noted_text_field.dart';

class CreateNoteView extends ConsumerStatefulWidget {
  const CreateNoteView({super.key});

  @override
  ConsumerState<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends ConsumerState<CreateNoteView> {
  final argument = Get.arguments;
  late ql.QuillController _controller;
  late TextEditingController _titleController;
  final _editorFocusNode = FocusNode();
  final _editorScrollController = ScrollController();
  late NoteManagerBloc noteManagerBloc;
  var _isReadOnly = false;
  bool isSaved = false;

  final doc = ql.Document()..insert(0, 'Welcome to Banter!');

  @override
  void initState() {
    super.initState();
    noteManagerBloc = ref.read(noteManagerBlocProvider);
    _initializeNoteData();
  }

  void _initializeNoteData() {
    List<dynamic>? bodyFromArg;
    String? titleFromArg;
    ql.Document? body;

    if (argument is NoteEntity) {
      bodyFromArg = argument?.body;
      titleFromArg = argument?.title;
    } else if (argument is StringMap) {
      bodyFromArg = argument?['note'].body;
      titleFromArg = argument?['note'].title;
    }
    if (bodyFromArg != null) {
      body = ql.Document.fromJson(bodyFromArg);
    }
    _controller = ql.QuillController(
      document: body ?? doc,
      selection: const TextSelection.collapsed(offset: 0),
    );

    _titleController = TextEditingController(text: titleFromArg ?? 'Untitled');
  }

  @override
  void dispose() {
    noteManagerBloc.close();
    _controller.dispose();
    _titleController.dispose();
    _editorFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    _controller.readOnly = _isReadOnly;

    return _buildNoteView(height, width);
  }

  Widget _buildNoteView(double height, double width) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopHandler,
      child: BlocProvider(
        create: (context) => ref.read(noteManagerBlocProvider),
        child: Scaffold(
          appBar: _buildAppBar(height, width),
          backgroundColor: BanterColors.darkBackground,
          body: _buildEditorBody(height, width),
        ),
      ),
    );
  }

  Future<void> _onPopHandler(bool canPop, _) async {
    if (argument is String || argument == null) {
      if (!isSaved) {
        _createNewNote();
      }
    } else if (argument is StringMap || argument is NoteEntity) {
      if (!isSaved) {
        _updateExistingNote();
      }
    }
  }

  void _createNewNote() {
    final noteId = UniqueKey();
    noteManagerBloc.add(
      CreateNewNoteEvent(
        id: noteId.toString(),
        title: _titleController.text,
        body: _controller.document.toDelta().toJson(),
        dateCreated: DateTime.now().toIso8601String(),
        lastEdited: DateTime.now().toIso8601String(),
        ownerId: '',
        folderIds: [argument ?? ''],
      ),
    );
    log('New note created');
  }

  void _updateExistingNote() {
    String? id;
    String? createdAt;
    List<String>? folders;
    String? mongoId;
    String? ownerId;
    int? version;

    if (argument is StringMap) {
      //Note is from folder
      id = argument['note'].id;
      createdAt = argument['note'].createdAt;
      folders = argument['note'].folderIds;
      mongoId = argument['note'].mongoId;
      ownerId = argument['note'].ownerId;
      version = argument['note'].version;
    } else {
      //Note is from general notes
      log('ARG: $argument');
      id = argument?.id;
      createdAt = argument?.createdAt;
      folders = argument?.folderIds;
      mongoId = argument?.mongoId;
      ownerId = argument?.ownerId;
      version = argument?.version;
    }
    final note = NoteEntity(
      id: id ?? '',
      title: _titleController.text,
      createdAt: createdAt ?? '',
      updatedAt: DateTime.now().toIso8601String(),
      body: _controller.document.toDelta().toJson(),
      folderIds: folders ?? [],
      ownerId: ownerId ?? '',
      mongoId: mongoId,
      version: version ?? 1,
      deleted: false,
      updated: true,
    );
    noteManagerBloc.add(
      UpdateNoteEvent(
        note: note,
      ),
    );
    log('Note edited');
  }

  AppBar _buildAppBar(double height, double width) {
    return AppBar(
      toolbarHeight: height * 0.10,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        _buildActionButton(width),
        Icon(
          Icons.more_vert_rounded,
          color: BanterColors.textColor1,
        ),
        Padding(padding: EdgeInsets.only(right: width*0.05))
      ],
      title: NotedTextField(
        isReadOnly: _isReadOnly,
        contentPadding: EdgeInsets.zero,
        hintText: 'Untitled',
        hintSize: width * 0.10,
        controller: _titleController,
        textSize: width * 0.10,
        isBorderless: true,
      ),
    );
  }

  IconButton _buildActionButton(double width) {
    return IconButton(
      onPressed: () => setState(() => _isReadOnly = !_isReadOnly),
      icon: Icon(
        _isReadOnly ? Icons.edit_rounded : Icons.remove_red_eye_outlined,
        color: BanterColors.textColor1,
        size: width * 0.05,
      ),
    );
  }

  Widget _buildEditorBody(double height, double width) {
    return BlocConsumer<NoteManagerBloc, NoteManagerState>(
      listener: _noteManagerListener,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              if (!_isReadOnly) ...[
                // Divider(color: Colors.grey.shade700),
                ToolsRevealer(
                  controller: _controller,
                ),
                Divider(color: Colors.grey.shade700),
              ],
              Expanded(
                child: ql.QuillEditor(
                  scrollController: _editorScrollController,
                  focusNode: _editorFocusNode,
                  controller: _controller,
                  configurations: ql.QuillEditorConfigurations(
                    scrollable: true,
                    customStyles: getDefaultTextStyle(width),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _noteManagerListener(BuildContext context, NoteManagerState state) {
    if (state is NoteCreated || state is NoteUpdated) {
      context.read<NoteManagerBloc>().add(const GetAllNotesEvent());
    }
    if (state is GottenNotes) {
      _handleGottenNotes(context, state);
    }
    if (state is GottenFolderNotes) {
      noteManagerBloc.add(ReorderNoteListEvent(notes: state.notes));
    }
    if (state is ReorderedNoteList) {
      final notes =
          List<NoteEntity>.from(state.notes).map((e) => e.toMap()).toList();
      context.read<NoteManagerBloc>().add(SetNoteEvent(notes: notes));
    }
    if (state is NoteSet) {
      setState(() => isSaved = true);
      Get.back();
    }
    if (state is NoteManagerError) {
      log('Note manager error: ${state.message}');
    }
  }

  void _handleGottenNotes(BuildContext context, GottenNotes state) {
    if (argument is String) {
      noteManagerBloc.add(
        GetFolderNotesEvent(
          notes: state.notes,
          folderId: argument,
        ),
      );
    } else if (argument is StringMap) {
      noteManagerBloc.add(
        GetFolderNotesEvent(
          notes: state.notes,
          folderId: argument['folderId'],
        ),
      );
    } else {
      noteManagerBloc.add(
        ReorderNoteListEvent(notes: state.notes),
      );
    }
  }
}
