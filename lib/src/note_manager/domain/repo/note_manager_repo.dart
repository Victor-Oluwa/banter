import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';

abstract class NoteManagerRepo {
  FutureResult<String> createNewNote({
    required String id,
    required String title,
    required List<StringMap> body,
    required String dateCreated,
    required String lastEdited,
    required String ownerId,
    required List<String> folderIds,
  });

  FutureResult<String> updateNote({
   required NoteEntity note,
  });

  FutureResult<List<NoteEntity>> getAllNotes();

  FutureResult<List<NoteEntity>> setNote({required List<StringMap> notes});

  FutureResult<List<FolderEntity>> getAllFolders();

  FutureResult<String> deleteNote({required String noteId});

  FutureResult<String> createFolder({required FolderEntity folder});

  FutureResult<String> renameFolder({required FolderEntity folder});

  FutureResult<String> deleteFolder({required String folderId});

  FutureResult<String> setFolder({required List<FolderEntity> folders});

  FutureResult<String> addNoteToFolder({
    required String folderId,
    required NoteEntity note,
  });

  FutureResult<String> removeNoteFromFolder({
    required NoteEntity note,
    required String folderId,
  });

  FutureResult<List<NoteEntity>> getFolderNotes({
    required List<NoteEntity> notes,
    required String folderId,
  });

  FutureResult<List<NoteEntity>> reorderNoteList(
      {required List<NoteEntity> notes});

  FutureResult<List<FolderEntity>> reorderFolderList(
      {required List<FolderEntity> folders});

  FutureResult<List<NoteEntity>> syncNotes({
    required List<NoteEntity>? notes,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  });

  FutureResult<List<FolderEntity>> syncFolders({
    required List<FolderEntity>? folders,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  });

}
