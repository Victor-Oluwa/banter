import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/use_case/add_note_to_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/create_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/create_new_note.dart';
import 'package:banter/src/note_manager/domain/use_case/delete_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/delete_note.dart';
import 'package:banter/src/note_manager/domain/use_case/getAllNotes.dart';
import 'package:banter/src/note_manager/domain/use_case/get_all_folders.dart';
import 'package:banter/src/note_manager/domain/use_case/get_folder_notes.dart';
import 'package:banter/src/note_manager/domain/use_case/remove_note_from_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/rename_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/reorder_folder_list.dart';
import 'package:banter/src/note_manager/domain/use_case/reorder_note_list.dart';
import 'package:banter/src/note_manager/domain/use_case/setNotes.dart';
import 'package:banter/src/note_manager/domain/use_case/set_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/sync_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/sync_notes.dart';
import 'package:banter/src/note_manager/domain/use_case/update_note.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_manager_event.dart';

part 'note_manager_state.dart';

class NoteManagerBloc extends Bloc<NoteManagerEvent, NoteManagerState> {
  NoteManagerBloc({
    required CreateNewNote createNewNote,
    required UpdateNote updateNote,
    required GetAllNotes getAllNotes,
    required SetNote setNote,
    required DeleteNote deleteNote,
    required CreateFolder createFolder,
    required RenameFolder renameFolder,
    required SetFolder setFolder,
    required DeleteFolder deleteFolder,
    required GetAllFolders getAllFolders,
    required AddNoteToFolder addNoteToFolder,
    required RemoveNoteFromFolder removeNoteFromFolder,
    required GetFolderNotes getFolderNotes,
    required ReorderFolderList reorderFolderList,
    required ReorderNoteList reorderNoteList,
    required SyncFolders syncFolders,
    required SyncNotes syncNotes,
  })  : _updateNote = updateNote,
        _createNewNote = createNewNote,
        _getAllNotes = getAllNotes,
        _setNote = setNote,
        _deleteNote = deleteNote,
        _createFolder = createFolder,
        _renameFolder = renameFolder,
        _setFolder = setFolder,
        _deleteFolder = deleteFolder,
        _getAllFolders = getAllFolders,
        _addNoteToFolder = addNoteToFolder,
        _removeNoteFromFolder = removeNoteFromFolder,
        _getFolderNotes = getFolderNotes,
        _reorderNoteList = reorderNoteList,
        _reorderFolderList = reorderFolderList,
        _syncFolders = syncFolders,
        _syncNotes = syncNotes,
        super(NoteManagerInitial()) {
    on<NoteManagerEvent>((event, emit) {
      emit(NoteManagerLoading());
    });

    on<CreateNewNoteEvent>(_createNewNoteEventHandler);
    on<UpdateNoteEvent>(_updateNoteEventHandler);
    on<GetAllNotesEvent>(_getAllNotesEventHandler);
    on<SetNoteEvent>(_setNoteEventHandler);

    on<DeleteNoteEvent>(_deleteNoteEventHandler);
    on<CreateFolderEvent>(_createFolderEventHandler);
    on<RenameFolderEvent>(_renameFolderEventHandler);
    on<SetFolderEvent>(_setFolderEventHandler);
    on<DeleteFolderEvent>(_deleteFolderEventHandler);
    on<GetAllFolderEvent>(_getAllFolderEventHandler);
    on<AddNoteToFolderEvent>(_addNoteToFolderEventHandler);
    on<RemoveNoteFromFolderEvent>(_removeNoteFromFolderEventHandler);
    on<GetFolderNotesEvent>(_getFolderNotesEventHandler);
    on<ReorderNoteListEvent>(_reorderNoteListEventHandler);
    on<ReorderFolderListEvent>(_reorderFolderListEventHandler);
    on<SyncFoldersEvent>(_syncFoldersEventHandler);
    on<SyncNotesEvent>(_syncNotesEventHandler);
    on<ConfirmSyncCompletionEvent>(_syncCompletionEventHandler);
  }

  final CreateNewNote _createNewNote;
  final UpdateNote _updateNote;
  final GetAllNotes _getAllNotes;
  final SetNote _setNote;
  final DeleteNote _deleteNote;
  final CreateFolder _createFolder;
  final RenameFolder _renameFolder;
  final DeleteFolder _deleteFolder;
  final SetFolder _setFolder;
  final GetAllFolders _getAllFolders;
  final AddNoteToFolder _addNoteToFolder;
  final RemoveNoteFromFolder _removeNoteFromFolder;
  final GetFolderNotes _getFolderNotes;
  final ReorderFolderList _reorderFolderList;
  final ReorderNoteList _reorderNoteList;
  final SyncFolders _syncFolders;
  final SyncNotes _syncNotes;

  void _createNewNoteEventHandler(
    CreateNewNoteEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _createNewNote(
      CreateNewNoteParam(
          id: event.id,
          title: event.title,
          body: event.body,
          dateCreated: event.dateCreated,
          lastEdited: event.lastEdited,
          ownerId: event.ownerId,
          folderIds: event.folderIds),
    );

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        NoteCreated(message: r),
      ),
    );
  }

  void _updateNoteEventHandler(
    UpdateNoteEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _updateNote(
      event.note,
    );

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        NoteUpdated(message: r),
      ),
    );
  }

  void _getAllNotesEventHandler(
    GetAllNotesEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _getAllNotes();

    result.fold(
      (l) => emit(
        NoteManagerError(message: l.errorMessage),
      ),
      (r) => emit(
        GottenNotes(notes: r),
      ),
    );
  }

  void _setNoteEventHandler(
    SetNoteEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _setNote(event.notes);

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        NoteSet(r),
      ),
    );
  }

  void _deleteNoteEventHandler(
    DeleteNoteEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _deleteNote(event.noteId);
    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        NoteDeleted(r),
      ),
    );
  }

  void _createFolderEventHandler(
      CreateFolderEvent event, Emitter<NoteManagerState> emit) async {
    final result = await _createFolder(event.folder);
    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        FolderCreated(r),
      ),
    );
  }

  void _renameFolderEventHandler(
      RenameFolderEvent event, Emitter<NoteManagerState> emit) async {
    final result = await _renameFolder(event.folder);
    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(FolderRenamed(r)),
    );
  }

  void _setFolderEventHandler(
      SetFolderEvent event, Emitter<NoteManagerState> emit) async {
    final result = await _setFolder(event.folders);
    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        FolderSet(r),
      ),
    );
  }

  void _deleteFolderEventHandler(
      DeleteFolderEvent event, Emitter<NoteManagerState> emit) async {
    final result = await _deleteFolder(event.folderId);
    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        FolderDeleted(r),
      ),
    );
  }

  void _getAllFolderEventHandler(
    GetAllFolderEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _getAllFolders();

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        GottenFolders(r),
      ),
    );
  }

  void _addNoteToFolderEventHandler(
    AddNoteToFolderEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _addNoteToFolder(
      AddNoteToFolderParams(
        note: event.note,
        folderId: event.folderId,
      ),
    );

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        NoteAddedToFolder(message: r),
      ),
    );
  }

  void _removeNoteFromFolderEventHandler(
    RemoveNoteFromFolderEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _removeNoteFromFolder(
      RemoveNoteFromFolderParams(
        note: event.note,
        folderId: event.folderId,
      ),
    );

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        RemovedNoteFromFolder(r),
      ),
    );
  }

  void _getFolderNotesEventHandler(
    GetFolderNotesEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _getFolderNotes(
      GetFolderNotesParams(
        notes: event.notes,
        folderId: event.folderId,
      ),
    );

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        GottenFolderNotes(notes: r),
      ),
    );
  }

  void _reorderNoteListEventHandler(
    ReorderNoteListEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _reorderNoteList(event.notes);

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        ReorderedNoteList(notes: r),
      ),
    );
  }

  void _reorderFolderListEventHandler(
    ReorderFolderListEvent event,
    Emitter<NoteManagerState> emit,
  ) async {
    final result = await _reorderFolderList(event.folders);

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        ReorderedFolderList(folders: r),
      ),
    );
  }

  void _syncNotesEventHandler(
      SyncNotesEvent event, Emitter<NoteManagerState> emit) async {
    final result = await _syncNotes(SyncNotesParams(
      notes: event.notes,
      userId: event.userId,
      lastSyncTime: event.lastSyncTime,
      page: event.page,
      limit: event.limit,
    ));

    result.fold(
      (l) => emit(SyncNoteError(message: l.errorMessage)),
      (r) => emit(
        SyncedNotes(notes: r),
      ),
    );
  }

  void _syncFoldersEventHandler(
      SyncFoldersEvent event, Emitter<NoteManagerState> emit) async {
    final result = await _syncFolders(SyncFoldersParams(
      folders: event.folders,
      userId: event.userId,
      lastSyncTime: event.lastSyncTime,
      page: event.page,
      limit: event.limit,
    ));

    result.fold(
      (l) => emit(NoteManagerError(message: l.errorMessage)),
      (r) => emit(
        SyncedFolders(folders: r),
      ),
    );
  }

  void _syncCompletionEventHandler(
      ConfirmSyncCompletionEvent event, Emitter<NoteManagerState> emit) {
    emit(const SyncCompleted());
  }
}
