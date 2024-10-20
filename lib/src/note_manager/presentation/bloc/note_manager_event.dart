part of 'note_manager_bloc.dart';

sealed class NoteManagerEvent extends Equatable {
  const NoteManagerEvent();
}

class CreateNewNoteEvent extends NoteManagerEvent {
  final String id;
  final String title;
  final List<StringMap> body;
  final String dateCreated;
  final String lastEdited;
  final String ownerId;
  final List<String> folderIds;

  const CreateNewNoteEvent({
    required this.id,
    required this.title,
    required this.body,
    required this.dateCreated,
    required this.lastEdited,
    required this.ownerId,
    required this.folderIds,
  });

  @override
  List<dynamic> get props => [
        id,
        title,
        body,
        dateCreated,
        lastEdited,
        ownerId,
        folderIds,
      ];
}

class UpdateNoteEvent extends NoteManagerEvent {
  final NoteEntity note;

  const UpdateNoteEvent({
    required this.note,
  });

  @override
  List<dynamic> get props => [note];
}

class GetAllNotesEvent extends NoteManagerEvent {
  const GetAllNotesEvent();

  @override
  List<dynamic> get props => [];
}

class SetNoteEvent extends NoteManagerEvent {
  final List<StringMap> notes;

  const SetNoteEvent({required this.notes});

  @override
  List<List<StringMap>> get props => [notes];
}

class DeleteNoteEvent extends NoteManagerEvent {
  final String noteId;

  const DeleteNoteEvent(this.noteId);

  @override
  List<String> get props => [noteId];
}

class CreateFolderEvent extends NoteManagerEvent {
  final FolderEntity folder;

  const CreateFolderEvent(this.folder);

  @override
  List<FolderEntity> get props => [folder];
}

class DeleteFolderEvent extends NoteManagerEvent {
  final String folderId;

  const DeleteFolderEvent(this.folderId);

  @override
  List<String> get props => [folderId];
}

class RenameFolderEvent extends NoteManagerEvent {
  final FolderEntity folder;

  const RenameFolderEvent(this.folder);

  @override
  List<FolderEntity> get props => [folder];
}

class SetFolderEvent extends NoteManagerEvent {
  final List<FolderEntity> folders;

  const SetFolderEvent(this.folders);

  @override
  List<List<FolderEntity>> get props => [folders];
}

class GetAllFolderEvent extends NoteManagerEvent {
  @override
  List get props => [];
}

class AddNoteToFolderEvent extends NoteManagerEvent {
  final String folderId;
  final NoteEntity note;

  const AddNoteToFolderEvent({required this.folderId, required this.note});

  @override
  List<dynamic> get props => [folderId, note];
}

class RemoveNoteFromFolderEvent extends NoteManagerEvent {
  final String folderId;
  final NoteEntity note;

  const RemoveNoteFromFolderEvent({required this.folderId, required this.note});

  @override
  List<dynamic> get props => [folderId, note];
}

class GetFolderNotesEvent extends NoteManagerEvent {
  final List<NoteEntity> notes;
  final String folderId;

  const GetFolderNotesEvent({required this.notes, required this.folderId});

  @override
  List<dynamic> get props => [folderId, notes];
}

class ReorderNoteListEvent extends NoteManagerEvent {
  final List<NoteEntity> notes;

  const ReorderNoteListEvent({required this.notes});

  @override
  List<List<NoteEntity>> get props => [notes];
}

class ReorderFolderListEvent extends NoteManagerEvent {
  final List<FolderEntity> folders;

  const ReorderFolderListEvent({required this.folders});

  @override
  List<List<FolderEntity>> get props => [folders];
}

class SyncFoldersEvent extends NoteManagerEvent {
  final List<FolderEntity>? folders;
  final String userId;
  final DateTime? lastSyncTime;
  final int page;
  final int limit;

  const SyncFoldersEvent({
    required this.folders,
    required this.userId,
    required this.lastSyncTime,
    required this.page,
    required this.limit,
  });

  @override
  List<dynamic> get props => [folders, userId, lastSyncTime, page, limit];
}

class SyncNotesEvent extends NoteManagerEvent {
  final List<NoteEntity>? notes;
  final String userId;
  final DateTime? lastSyncTime;
  final int page;
  final int limit;

  const SyncNotesEvent({
    required this.notes,
    required this.userId,
    required this.lastSyncTime,
    required this.page,
    required this.limit,
  });

  @override
  List<dynamic> get props => [notes, userId, lastSyncTime, page, limit];
}

class ConfirmSyncCompletionEvent extends NoteManagerEvent{
  const ConfirmSyncCompletionEvent();

  @override
  List<dynamic> get props => [];
}
